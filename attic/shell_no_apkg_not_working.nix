with import <nixpkgs> {};
let
  deps = (import ./deps.nix);
  myEmacs = (import ./emacs.nix { inherit pkgs; });
  
in
 deps + agda.mkDerivation(self:  {
  name = "agdaShellEnv";
  dontUnpack = true;
  buildInputs = deps.buildInputs ++ [
    myEmacs
  ];
  # libPath = deps.libPath;
  src = null;
  shellHook = ''
    export ORIG_HOME=$HOME
    export AGDA_PROJECT_HOME=$PWD
    export HOME=$AGDA_PROJECT_HOME

    echo '(load-file "~/.emacs")' > $AGDA_PROJECT_HOME/.emacs
    agda-mode setup

    export HOME=$ORIG_HOME
    unset ORIG_HOME
    msmacs () {
      emacs -Q --load $AGDA_PROJECT_HOME/.emacs $@
    }
  '';
}).env
