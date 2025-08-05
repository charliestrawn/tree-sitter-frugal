# Neovim Setup for tree-sitter-frugal

This guide shows how to configure Neovim to use the tree-sitter-frugal parser for syntax highlighting.

## Problem

Neovim's tree-sitter doesn't automatically recognize custom parsers like tree-sitter-frugal. You need to manually register the parser and configure filetype detection.

## Solution

### 1. Add Parser Configuration

Add this to your Neovim configuration (typically in `init.lua`):

```lua
-- Register the Frugal parser
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.frugal = {
  install_info = {
    url = "https://github.com/charliestrawn/tree-sitter-frugal",
    files = {"src/parser.c"},
    branch = "master",
    generate_requires_npm = false,
  },
  filetype = "frugal",
}
```

### 2. Add to Tree-sitter Configuration

Update your tree-sitter setup to include Frugal:

```lua
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "bash", "c", "diff", "go", "html", "lua", "markdown", 
    "tsx", "typescript", "vim", "vimdoc",
    "frugal", -- Add this line
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
```

### 3. Register Filetype Detection

Add filetype detection for `.frugal` files:

```lua
-- Add to your init.lua
vim.filetype.add({
  extension = {
    frugal = "frugal",
  },
})
```

### 4. Install the Parser

Run this command in Neovim:
```
:TSInstall frugal
```

This will automatically download the parser from GitHub and install the query files.

### 5. Test

Open a `.frugal` file and check if highlighting works:
```
:TSHighlightCapturesUnderCursor
```

This should show the highlight groups being applied.

## Troubleshooting

If highlighting still doesn't work:

1. Check if the parser compiled correctly:
   ```
   :TSInstallInfo frugal
   ```

2. Verify queries are loaded:
   ```
   :TSEditQuery frugal highlights
   ```

3. Make sure the filetype is detected:
   ```
   :set filetype?
   ```
   Should show `filetype=frugal` when editing a `.frugal` file.