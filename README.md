# My neovim configuration

Experimental (neo)vim configuration utilizing coc.nvim and related extension plugins.

## Install

Requirements:
- python-neovim
- neovim-nightly (required for floating windows coming in 0.4)
- npm (npx is used during installation)
- nodejs (see https://github.com/neoclide/coc.nvim)
- yarn (see https://github.com/neoclide/coc.nvim)
- rustup (see https://github.com/neoclide/coc-rls)
- flake8 (Python PEP8 linter, configured in coc-settings.json)
- ripgrep
- ctags

```bash
cd ~
mv .config/nvim .config/nvim.bak  # backup current neovim configuration if present
git clone https://github.com/necabo/dotcocnvim.git .cocnvim
cd .cocnvim && ./install.sh
```

## Usage

| Key           | Description                   |
| ------------- | ----------------------------- |
| <kbd>F1</kbd> | open :help                    |
| <kbd>F2</kbd> | open file browser (nerd tree) |
| <kbd>F3</kbd> | toggle paste mode             |
| <kbd>F4</kbd> | open fuzzy find               |
