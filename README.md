# .dotfiles

Run `./mac` to install dotfiles to a macos environment.
The folders to symlink can be defined by environment through an env var: `STOW_FOLDERS=personal ./mac`

Uses [stow](https://www.gnu.org/software/stow/) to sanely manage symlinks. Stow symlinks the directory structure to the parent directory and intelligently handles nested structures.
