with import <nixpkgs> {};
let
  # thisAgda = pkgs.haskellPackages.ghcWithPackages ( p: [p.Agda p.ieee754] );
  thisAgda = pkgs.agda;
in
stdenv.mkDerivation {
  name = "commonAgdaDeps";
  dontUnpack = true;
  myAgda = thisAgda;
  buildDepends = [
    thisAgda
    # Using agda-pkg instead for deps for now:
    # pkgs.AgdaStdlib (pkgs.haskellPackages.ghcWithPackages ( p: [p.ieee]) )
    # pkgs.agdaPrelude (pkgs.haskellPackages.ghcWithPackages ( p: [p.ieee]) )
  ];
  src = null;
}
