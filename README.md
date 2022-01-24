# .dotfiles

![image](https://user-images.githubusercontent.com/1642339/150747923-4a0e0586-4732-41f0-b033-3f9e96dfeb87.png)

### Usage

Run `./mac` to install dotfiles to a macos environment.
The folders to symlink can be defined by environment through an env var: `STOW_FOLDERS=personal ./mac`

Uses [stow](https://www.gnu.org/software/stow/) to sanely manage symlinks. Stow symlinks the directory structure to the parent directory and intelligently handles nested structures.

### Codespaces

- `install.sh` will be executed during codespace creation
