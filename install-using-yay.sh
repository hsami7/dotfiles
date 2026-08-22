#!/usr/bin/env bash

# --- 1. Bootstrap yay (AUR Helper) ---
if ! command -v yay &> /dev/null; then
    echo "yay not found. Installing..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay
    makepkg -si --noconfirm
    popd
fi

# --- 2. System Update ---
yay -Syu --noconfirm

# --- 3. Install Core CLI Tools ---
yay -S --needed --noconfirm \
    fzf thefuck zoxide eza bat ripgrep fd \
    tmux stow neovim lazygit nodejs npm \
    starship yazi smartmontools \
    bluetui brightnessctl btop claude-code cliamp \
    dust dysk fastfetch github-cli glow htop \
    lazydocker mise ngrok tailscale timeshift \
    ufw ufw-docker wl-clipboard zram-generator

# --- 4. Install GUI Apps & Environment ---
yay -S --needed --noconfirm \
    kitty waybar hyprland rofi wofi \
    obsidian 1password 1password-beta 1password-cli localsend vlc \
    alacritty brave-bin chromium code helium-browser-bin \
    imv keyd mission-center mpv nautilus obs-studio \
    opencode remmina satty signal-desktop spotify swaybg \
    swayosd walker ttf-cascadia-code-nerd ttf-ia-writer \
    ttf-jetbrains-mono-nerd aether

# --- 5. Zsh Plugins & Theme ---
yay -S --needed --noconfirm \
    zsh-theme-powerlevel10k \
    zsh-autosuggestions \
    zsh-syntax-highlighting

# --- 6. Manual Plugin Setup (Non-Pacman) ---
mkdir -p ~/.local/share
mkdir -p ~/.tmux/plugins

# TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# fzf-git.sh
if [ ! -d ~/.local/share/fzf-git ]; then
    git clone https://github.com/junegunn/fzf-git.sh.git ~/.local/share/fzf-git
fi

echo "Installation complete! Remember to link your dotfiles using stow or symlinks."

