# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles (macOS-first, Linuxbrew-compatible). Everything under `home/` is symlinked into `$HOME` with GNU Stow; `iterm2/` holds iTerm2 exports/color presets that are imported manually, not stowed.

## Commands

- `make` — full bootstrap: brew/cargo/node packages, neovim, fzf, zsh plugins (cloned into `~/.zsh`), stow link, tmux-256color terminfo.
- `make link` / `make unlink` — (re)create or remove the symlinks only. Uses `stow --no-folding`, so links are per-file, never per-directory — new files under `home/` need `make link` to appear in `$HOME`.
- `make update-zsh-plugins` — `git pull` every plugin in `~/.zsh`.
- Lua formatting for the Neovim config: `stylua home/.config/nvim` (config in `home/.config/nvim/.stylua.toml`: 2-space indent, single quotes, always use call parentheses, 160 cols).

There are no tests or CI.

## Architecture notes

- **Paths:** `.zshenv` sets `XDG_CONFIG_HOME=$HOME/.config`; configs reference `$XDG_CONFIG_HOME` rather than `~/.config`.
- **Shared light/dark theme:** the single source of truth is the file `$XDG_CONFIG_HOME/theme` containing `light` or `dark` (not tracked; `.zshrc` creates it with `dark`). The `set-theme` / `toggle-theme` zsh functions in `home/.zshrc` write it and then propagate live:
  - tmux: re-sources `tmux/tmux-set-theme.conf`, which picks `tmux-light-theme.conf` or `tmux-dark-theme.conf`.
  - Neovim: sends `:set background=…` to every running instance via `nvim-*.pipe` sockets under `$XDG_DATA_HOME/nvim`; `init.lua` also reads the file at startup.
  - iTerm2: runs `iterm2/set-theme.py` (iTerm2 Python API) to apply the color preset named after the theme to all profiles.
  - fzf colors read the file in `FZF_DEFAULT_OPTS`.
  Any new themed tool should hook into this same file/function.
- **Neovim:** `init.lua` is the main file (options, keymaps, and the lazy.nvim plugin spec, bootstrapped on first run). Heavier plugin setup is split into `lua/plugins/*.lua` and pulled in via `require('plugins/<name>')` from the corresponding plugin's `config` in `init.lua` — these are not lazy.nvim spec files. Per-filetype settings live in `after/ftplugin/`.
- **Git:** `home/.config/git/config` conditionally includes `config-work` for repos under `~/git/quaestor/` (`includeIf gitdir`).
