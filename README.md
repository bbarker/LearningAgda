# Nix usage

`nix-shell` from the current directory.

To launch emacs with agda-mode enabled, run `mymacs` in the newly launched shell;
`mymacs` will still use your `~/.emacs file as well`

## Configuration

Edit any of the nix expressions as needed. In particular:

1. To add more Haskell or other system dependencies, edit `deps.nix`.
2. To add or alter the editor used, change the `myEmacs`
  references in `shell.nix` or add similar derivations.
3. Optionally, create `.emacs_user_config` in the repository root directory and
  add any additional config, such as `(setq agda2-backend "GHC")` to use GHC by
  default when compiling Agda files from emacs.
 