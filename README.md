# dotfiles

Personal configuration, built for speed and simplicity. Catppuccin Macchiato
everywhere.

## Requirements

- [Alacritty](https://alacritty.org/)
- [tmux](https://github.com/tmux/tmux) (>= 3.0)
- [Neovim](https://neovim.io/) (>= 0.9)
- A [Nerd Font](https://www.nerdfonts.com/) (using CaskaydiaMono Nerd Font. BitstreamVera is also an option)
- `git`

## Installation

Clone the repo and symlink each config to the path its program expects:

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles

ln -sf "$PWD/alacritty" ~/.config/alacritty
ln -sf "$PWD/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$PWD/nvim" ~/.config/nvim
```

Everything else installs itself on first use:

- **tmux**: on startup, `tmux.conf` clones [TPM](https://github.com/tmux-plugins/tpm)
  if it's missing and uses it to install the declared plugins. If something
  doesn't show up, `prefix + I` forces the install.
- **Neovim**: on first launch, `lazy.nvim` bootstraps itself and installs the
  plugins pinned in `lazy-lock.json`.

## Structure

```
alacritty/
  alacritty.toml            # main config
  catppuccin-macchiato.toml # theme, imported from alacritty.toml
tmux/
  tmux.conf                 # full config, commented line by line
nvim/
  init.lua                  # entrypoint: loads core + lazy.nvim
  lazy-lock.json             # pinned plugin versions
  lua/voref/
    core/                   # options.lua and keymaps.lua (no plugins)
    plugins/                # one file per plugin, loaded by lazy.nvim
```

## Alacritty

No decorations, starts maximized. `F10` toggles maximized, `F11` toggles
fullscreen. Font: CaskaydiaMono Nerd Font.

## tmux

- Prefix: `Ctrl-Space` (instead of the default `Ctrl-b`).
- `"` and `%` open vertical/horizontal splits, keeping the current directory.
- Pane navigation with `Ctrl-h/j/k/l`, integrated with Neovim via
  [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
  (the same keys move between tmux splits and nvim splits regardless of
  which one has focus).
- Vi-style copy mode, mouse enabled, 50k lines of scrollback.

### Plugins (via TPM)

| Plugin | Purpose |
| --- | --- |
| [tpm](https://github.com/tmux-plugins/tpm) | Plugin manager itself, installs and loads the rest. |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Catppuccin Macchiato theme for the status bar and pane borders. |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Copies tmux selections to the system clipboard. |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | `Ctrl-h/j/k/l` move between tmux panes and Neovim splits transparently, regardless of which one has focus. |

## Neovim

Built around [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin
manager. `init.lua` only loads `core` (options/keymaps, no dependencies) and
`lazy` (bootstrap + loads `lua/voref/plugins/*.lua`, one file per plugin).

Leader key: `Space`.

### Plugins

| Plugin | Purpose |
| --- | --- |
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | Colorscheme (Macchiato flavor), also drives highlight colors for other plugins below via its integrations. |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline (mode, file, git branch, diagnostics). |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer sidebar, toggled with `Ctrl-n`. |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder: files, live grep, buffers, help tags, git status (`<leader>f*`, `<leader>gs`). |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git status in the sign column, hunk staging/reset/preview, blame (`<leader>h*`). |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Popup showing available keybindings as you type a prefix. |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Treesitter parsers + highlighting/indent for the languages in `plugins/lint.lua` (currently lua, python, terraform, yaml, bash, markdown). |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Runs external linters on save (linter binaries must be installed separately, see `plugins/lint.lua`). |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-closes brackets/quotes. |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Neovim side of the tmux pane navigation (see tmux section above). |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides, plus a highlighted guide for the current treesitter scope (function/if/for/while/do blocks). |
