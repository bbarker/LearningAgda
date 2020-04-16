## Preamble

While this repository has example sources, it can also be used as a template to create an Agda project in Nix or NixOS. Just delete the `examples` and `attic` directoreis once you are sure the environment works as expected and then add your own sources.


## Nix usage

`nix-shell` from the current directory.

To launch emacs with agda-mode enabled, run `mymacs` in the newly launched shell;
`mymacs` will also load your `~/.emacs` file if it exists. If you are using
[spacemacs](https://www.spacemacs.org), you will need to edit `shell.nix`
to use `~/.spacemacs` instead.

**Examle**: run `mymacs  examples/hello/hello-world.agda` then type `C-c C-x C-c` in emacs
to compile the loaded hello world file.

### Configuration

Edit any of the nix expressions as needed. In particular:

0. To add Agda dependencies via agda-pkg, edit `requirements.txt` 
1. To add more Haskell or other system dependencies or other
  target-language dependencies, edit `deps.nix`.
2. To add or alter the editor used, change the `myEmacs`
  references in `shell.nix` or add similar derivations.
3. Optionally, create `.emacs_user_config` in the repository root directory and
  add any additional config, such as `(setq agda2-backend "GHC")` to use GHC by
  default when compiling Agda files from emacs.
 
