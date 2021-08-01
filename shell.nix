let
  pkgs = import (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/refs/tags/21.11-pre.tar.gz";
    sha256 = "0ww19c7n4fj9zn770aw8zaqld742bi9sa9s8hqb3vrgp3mpihil0";
  }) { };
  deps = (import ./deps.nix);
  myEmacs = (import ./emacs.nix { inherit pkgs; });
  
  # The standard library in nixpkgs does not come with a *.agda-lib file, so we
  # generate it here.
  standard-library-agda-lib = pkgs.writeText "standard-library.agda-lib" ''
    name: standard-library
    include: ${pkgs.agdaPackages.standard-library}/share/agda
  '';

  # Agda uses the AGDA_DIR environmental variable to determine where to load
  # default libraries from. This should have a few files in it, including the
  # "defaults" and "libraries" files generated below.
  #
  # More information (and possibilities!) are detailed here:
  # https://agda.readthedocs.io/en/v2.6.0.1/tools/package-system.html
  agdaDir = pkgs.stdenv.mkDerivation {
    name = "agdaDir";

    phases = [ "installPhase" ];

    # If you want to add more libraries simply list more in the $out/libraries
    # and $out/defaults folder.
    installPhase = ''
      mkdir $out
      echo "${standard-library-agda-lib}" >> $out/libraries
      echo "standard-library" >> $out/defaults
    '';
  };

in pkgs.mkShell {
  name = "agda-shell-with-stdlib";
  # builtInputs = deps.buildInputs ++ [ myEmacs ];
  packages = deps.buildDepends ++ [ myEmacs ];

  # The build environment's $AGDA_DIR is set through this call.
  AGDA_DIR = agdaDir;
  
  shellHook = ''
    export AGDA_PROJ_DIR=$PWD

    if [ ! -f "$AGDA_PROJ_DIR/.emacs" ]; then
      export ORIG_HOME=$HOME
      export HOME=$AGDA_PROJ_DIR

      echo '(load (expand-file-name "~/.emacs") "" nil t)' > $AGDA_PROJ_DIR/.emacs
      agda-mode setup
      export EMACS_USER_FILE="$AGDA_PROJ_DIR/.emacs_user_config"
      if [ -f "$EMACS_USER_FILE" ]; then
        cat "$EMACS_USER_FILE" >> $AGDA_PROJ_DIR/.emacs
      fi
      export HOME=$ORIG_HOME
      unset ORIG_HOME
      rmdir .emacs.d
      unset EMACS_USER_FILE
    fi
  
    agmacs () {
      emacs -Q --load $AGDA_PROJ_DIR/.emacs $@
    }
  '';
  
}
