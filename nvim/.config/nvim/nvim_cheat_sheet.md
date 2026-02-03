# Neovim Cheat Sheet

This cheat sheet provides a quick reference for common Neovim/Vim commands configured in this project, excluding plugin-specific keybindings. The leader key (`<leader>`) is set to `Space`.

## File Operations

### Save/Exit

*   **Normal Mode:**
    *   `<C-s>`: Save file (`:w`)
    *   `<leader>sn`: Save file without auto-formatting (`:noautocmd w`)
    *   `<C-q>`: Quit current window (`:q`)

## Navigation

### Text Movement

*   **Normal Mode:**
    *   `x`: Delete character without yanking (`"_x`)
    *   `<C-d>`: Scroll half page down and center cursor (`<C-d>zz`)
    *   `<C-u>`: Scroll half page up and center cursor (`<C-u>zz`)
    *   `n`: Go to next search result and center view (`nzzzv`)
    *   `N`: Go to previous search result and center view (`Nzzzv`)
    *   `<Up>`: Move cursor up (`k`)
    *   `<Down>`: Move cursor down (`j`)
    *   `<Left>`: Move cursor left (`h`)
    *   `<Right>`: Move cursor right (`l`)
*   **Visual Mode:**
    *   `<`: Maintain indent after shift (`<gv`)
    *   `>`: Maintain indent after shift (`>gv`)
    *   `p`: Paste without yanking current selection (`"_dP`)

### Buffer/Window/Tab Management

*   **Normal Mode:**
    *   `<Tab>`: Go to next buffer (`:bnext`)
    *   `<S-Tab>`: Go to previous buffer (`:bprevious`)
    *   `<leader>bx`: Close current buffer (`:bdelete!`)
    *   `<leader>bn`: Create new buffer (`:enew`)
    *   `<leader>sv`: Split window vertically (`<C-w>v`)
    *   `<leader>sh`: Split window horizontally (`<C-w>s`)
    *   `<leader>se`: Make splits equal size (`<C-w>=`)
    *   `<leader>sx`: Close current split (`:close`)
    *   `<C-k>`: Move to upper split (`:wincmd k`)
    *   `<C-j>`: Move to lower split (`:wincmd j`)
    *   `<C-h>`: Move to left split (`:wincmd h`)
    *   `<C-l>`: Move to right split (`:wincmd l`)
    *   `<leader>to`: Open new tab (`:tabnew`)
    *   `<leader>tx`: Close current tab (`:tabclose`)
    *   `<leader>tn`: Go to next tab (`:tabn`)
    *   `<leader>tp`: Go to previous tab (`:tabp`)

## Other General Commands

*   **Normal Mode:**
    *   `<leader>lw`: Toggle line wrapping (`:set wrap!`)