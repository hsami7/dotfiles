# Dotfiles Keybindings Reference

This document centralizes all custom keybindings and aliases configured in this dotfiles repository.

---

## 🟢 Tmux (Terminal Multiplexer)
*File: `.tmux.conf`*
*Prefix Key: `Ctrl + a`*

### Management
| Keybind | Action |
| :--- | :--- |
| `Prefix` + `r` | Reload tmux configuration |
| `Prefix` + `,` | Rename current window |
| `Prefix` + `$` | Rename current session |

### Panes & Windows
| Keybind | Action |
| :--- | :--- |
| `Prefix` + `\|` | Split pane vertically |
| `Prefix` + `-` | Split pane horizontally |
| `Prefix` + `m` | Maximize/Restore current pane |
| `Prefix` + `x` | Kill current pane |
| `Prefix` + `c` | Create new window |
| `Prefix` + `&` | Kill current window |

### Navigation & Resizing
| Keybind | Action |
| :--- | :--- |
| `Ctrl + h/j/k/l` | Seamlessly move between Panes (and Neovim splits) |
| `Prefix` + `h/j/k/l` | Resize pane (5 unit increments) |

### Copy Mode (Vim-style)
| Keybind | Action |
| :--- | :--- |
| `Prefix` + `[` | Enter Copy Mode |
| `v` | Start visual selection |
| `y` | Yank (Copy) selected text |
| `q` | Exit copy mode |

### Session Persistence (Manual)
| Keybind | Action |
| :--- | :--- |
| `Prefix` + `Ctrl + s` | Save session (manual) |
| `Prefix` + `Ctrl + r` | Restore session (manual) |

---

## 🔵 Neovim (Text Editor)
*File: `.config/nvim/lua/core/keymaps.lua`*
*Leader Key: `Space`*

### General
| Keybind | Action |
| :--- | :--- |
| `jk` | Exit insert mode |
| `Space` + `nh` | Clear search highlights |
| `Ctrl + s` | Save file |
| `Ctrl + q` | Quit current window |

### Navigation
| Keybind | Action |
| :--- | :--- |
| `Ctrl + d/u` | Scroll half-page down/up and center |
| `Tab` | Next buffer |
| `Shift + Tab` | Previous buffer |
| `Space` + `bx` | Close current buffer |

### Window Management
| Keybind | Action |
| :--- | :--- |
| `Space` + `sv` | Split window vertically |
| `Space` + `sh` | Split window horizontally |
| `Space` + `sx` | Close current split |
| `Space` + `se` | Make splits equal size |
| `Ctrl + h/j/k/l` | Navigate between splits |

### Plugins
| Keybind | Action |
| :--- | :--- |
| `Space` + `ee` | Toggle File Explorer (NvimTree) |
| `Space` + `ff` | Find Files (Telescope) |
| `Space` + `fs` | Live Grep / Search Text (Telescope) |
| `Space` + `lg` | Open LazyGit |
| `Space` + `xx` | Toggle Diagnostics (Trouble) |

---

## 🟡 Zsh (Shell Aliases)
*File: `.zshrc`*

### Navigation & Tools
| Alias | Command | Description |
| :--- | :--- | :--- |
| `cd` | `z` | Jump to directories (zoxide) |
| `ls` | `eza --icons ...` | Modern file listing (eza) |
| `cl` | `clear` | Clear terminal |
| `bat` | `batcat` | Cat with syntax highlighting |
| `lg` | `lazygit` | Terminal Git UI |

### Git Shortcuts
| Alias | Command | Description |
| :--- | :--- | :--- |
| `gaa` | `git add .` | Add all changes |
| `gmt` | `git commit -m` | Commit with message |
| `gp` | `git push` | Push to remote |
