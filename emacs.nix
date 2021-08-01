{ pkgs ? import <nixpkgs> {} }: 
let
  # myEmacs = pkgs.emacs27-nox;
  myEmacs = pkgs.emacs27; 
  emacsWithPackages = (pkgs.emacsPackagesGen myEmacs).emacsWithPackages;
  deps = (import ./deps.nix);
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [ 
    magit          # ; Integrate git <C-x g>
    zerodark-theme # ; Nicolas' theme
  ]) ++ (with epkgs.melpaPackages; [ 
    # undo-tree      # ; <C-x u> to show the undo tree
    # zoom-frm       # ; increase/decrease font size for all buffers %lt;C-x C-+>
  ]) ++ (with epkgs.elpaPackages; [
    # auctex         # ; LaTeX mode; disabled, see https://github.com/nix-community/emacs-overlay/issues/124#issuecomment-890509424
    beacon         # ; highlight my cursor when scrolling
    nameless       # ; hide current package name everywhere in elisp code
  ]) ++ [
    deps.myAgda # This is where agda-mode is located
    # pkgs.notmuch   # From main packages set 
  ])
