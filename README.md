# DotFiles

Personal dotfiles managed with [yadm](https://yadm.io) (3.x). Supported: macOS, Debian, Arch Linux.

## Install

```sh
# macOS: brew install yadm   Debian: apt install yadm   Arch: pacman -S yadm
yadm clone --bootstrap git@github.com:Adrian-Grimm/DotFiles.git
```

If files already exist in `$HOME`, run `yadm checkout -- <file>` or move them away first.

## What bootstrap does (`~/.config/yadm/bootstrap`)

- macOS: installs Homebrew and runs `brew bundle --file ~/.config/homebrew/Brewfile`.
- Debian / Arch: installs packages from `~/.config/yadm/packages/{debian,arch}.txt`.
- Installs starship if missing, sets zsh as login shell, runs `yadm alt`.
- Re-running is safe.

## Layout

| Path | Purpose |
| --- | --- |
| `.zshrc` | zsh + zinit plugins, starship, zoxide, broot (all tool inits are guarded) |
| `.bashrc`, `.bash_profile` | bash + flyline |
| `.config/{starship.toml,ghostty,nvim,broot,lf,htop}` | tool configs (nvim = LazyVim) |
| `.tmux.conf.local` | settings for [oh-my-tmux](https://github.com/gpakosz/.tmux) (linked by zinit) |
| `.gitconfig`, `.psqlrc`, `.editorconfig` | misc |

### OS-specific files (yadm alternates)

`name##os.Darwin` / `name##os.Linux` are symlinked to `name` by `yadm alt`:
`.nanorc` (both OSes), `.config/aerospace/aerospace.toml` and the Brewfile (macOS only).

### Local, untracked overrides

`~/.zshrc.local`, `~/.gitconfig.local`, `~/.psqlrc.local`.
