#!/usr/bin/env bash

# ==============================================================================
# Omarchy System and User Config Backup Script
# This script bundles all key configurations, system-wide rules, and custom setups
# into a tarball so you don't lose anything during formatting.
# ==============================================================================

set -euo pipefail

# Output directory and filename
BACKUP_DIR_NAME="omarchy_backup_$(date +%F)"
BACKUP_PATH="$HOME/$BACKUP_DIR_NAME"
ZIP_FILE="/home/ngl/dotfiles/omarchy_backup/omarchy_backup.zip"

echo "=== Starting Omarchy Configuration Backup ==="
echo "Creating backup folder: $BACKUP_PATH"
mkdir -p "$BACKUP_PATH/user_config"
mkdir -p "$BACKUP_PATH/home_files"
mkdir -p "$BACKUP_PATH/system_config"
mkdir -p "$BACKUP_PATH/scripts"

# --- 1. User config files (~/.config) ---
echo "--> Backing up user configs (~/.config/)..."
CONFIG_DIRS=(
    "hypr"
    "waybar"
    "walker"
    "mako"
    "swayosd"
    "kitty"
    "alacritty"
    "ghostty"
    "foot"
    "omarchy"
    "aether"
    "nvim"
    "btop"
    "fastfetch"
    "lazygit"
    "git"
    "opencode"
    "yazi"
    "1password"
)

for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$HOME/.config/$dir" ]; then
        echo "  - Backing up ~/.config/$dir"
        cp -rP "$HOME/.config/$dir" "$BACKUP_PATH/user_config/"
    else
        echo "  - ~/.config/$dir not found, skipping."
    fi
done

# Individual files in ~/.config
if [ -f "$HOME/.config/starship.toml" ]; then
    echo "  - Backing up ~/.config/starship.toml"
    cp "$HOME/.config/starship.toml" "$BACKUP_PATH/user_config/"
fi

# --- 2. Home directory files ---
echo "--> Backing up home directory dotfiles..."
HOME_FILES=(
    ".zshrc"
    ".p10k.zsh"
    ".bashrc"
    ".profile"
    ".tmux.conf"
    ".XCompose"
)

for file in "${HOME_FILES[@]}"; do
    if [ -f "$HOME/$file" ]; then
        echo "  - Backing up ~/$file"
        cp "$HOME/$file" "$BACKUP_PATH/home_files/"
    fi
done

# --- 3. System-wide configuration files (etc) ---
echo "--> Backing up system configuration (/etc & /var)..."

# Functions to check and copy files that require sudo or read-access
copy_system_file() {
    local src="$1"
    local dest_dir="$2"
    if [ -f "$src" ]; then
        echo "  - Backing up $src"
        # Using cp -f, copying to backup dir (users can run this script with sudo or as normal user if files are readable)
        cp -f "$src" "$dest_dir/" 2>/dev/null || {
            echo "    [NOTE] Requires root access. Copying with sudo..."
            sudo cp -f "$src" "$dest_dir/"
        }
    fi
}

copy_system_file "/etc/systemd/zram-generator.conf" "$BACKUP_PATH/system_config"
copy_system_file "/etc/fstab" "$BACKUP_PATH/system_config"

# Udev rules
if [ -d "/etc/udev/rules.d" ]; then
    mkdir -p "$BACKUP_PATH/system_config/udev_rules"
    copy_system_file "/etc/udev/rules.d/99-power-profile.rules" "$BACKUP_PATH/system_config/udev_rules"
    copy_system_file "/etc/udev/rules.d/99-wifi-powersave.rules" "$BACKUP_PATH/system_config/udev_rules"
fi

# Networkd configurations
if [ -d "/etc/systemd/network" ]; then
    mkdir -p "$BACKUP_PATH/system_config/networkd"
    copy_system_file "/etc/systemd/network/10-wired.network" "$BACKUP_PATH/system_config/networkd"
    copy_system_file "/etc/systemd/network/15-wlan0-ap.network" "$BACKUP_PATH/system_config/networkd"
    copy_system_file "/etc/systemd/network/20-wireless.network" "$BACKUP_PATH/system_config/networkd"
fi

# iwd wireless configs
if [ -d "/var/lib/iwd" ]; then
    mkdir -p "$BACKUP_PATH/system_config/iwd"
    # Copy wireless AP hotspot profiles if exist
    if [ -d "/var/lib/iwd/ap" ]; then
        cp -rP "/var/lib/iwd/ap" "$BACKUP_PATH/system_config/iwd/" 2>/dev/null || {
            sudo cp -rP "/var/lib/iwd/ap" "$BACKUP_PATH/system_config/iwd/"
        }
    fi
fi

# --- 4. Custom scripts and lists ---
echo "--> Backing up custom scripts and lists..."
# Wifi hotspot sharing script
if [ -d "$HOME/.gemini/antigravity/scratch/wifi-hotspot" ]; then
    echo "  - Backing up wifi-hotspot scratch scripts"
    cp -r "$HOME/.gemini/antigravity/scratch/wifi-hotspot" "$BACKUP_PATH/scripts/"
fi

# Export pacman package lists
echo "--> Exporting lists of installed packages..."
pacman -Qe > "$BACKUP_PATH/installed_packages.txt"
pacman -Qem > "$BACKUP_PATH/installed_aur_packages.txt"
echo "  - Saved package lists to installed_packages.txt and installed_aur_packages.txt"

# --- 5. Compression ---
echo "--> Packaging the backup into a zip archive..."
rm -f "$ZIP_FILE"
cd "$HOME"
zip -r "$ZIP_FILE" "$BACKUP_DIR_NAME"
sudo chown "$(id -u):$(id -g)" "$ZIP_FILE"

# Clean up uncompressed folder
rm -rf "$BACKUP_PATH"

echo "================================================="
echo "SUCCESS!"
echo "Your Omarchy settings and system files are backed up at:"
echo "  $ZIP_FILE"
echo "================================================="
echo "This file has been placed inside your local dotfiles repository."
echo "Once committed and pushed, you can retrieve it by cloning the repo."
echo "================================================="
