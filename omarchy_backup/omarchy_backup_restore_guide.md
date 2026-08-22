# Omarchy Backup & Restore Guide

This guide details how to safeguard and restore all your custom settings, configurations, and system-wide modifications before formatting your laptop. 

We have automated the packaging of your configurations into a single zip archive:
* **Backup Path:** `~/dotfiles/omarchy_backup/omarchy_backup.zip` (Size: ~16MB)

---

## 📦 What is Backed Up in the Archive

The automated script has packaged the following components:

### 1. User Configurations (`~/.config/`)
All customization configs for your desktop environment, window manager, and shell tools:
* `hypr/` - Window manager rules, custom keybindings, monitor layouts, idle & lockscreen configs
* `waybar/` - Status bar layout (`config.jsonc`) and styling (`style.css`)
* `walker/` - Application launcher configurations
* `mako/` - Desktop notification settings
* `swayosd/` - On-screen display styles
* `aether/` - Custom themes, colors, and layout blueprints (linked to your Omarchy theme)
* `omarchy/` - Theme, backgrounds, and hooks directories
* `kitty/`, `alacritty/`, `ghostty/` - Terminal configurations
* `nvim/` - Neovim text editor settings
* `btop/`, `fastfetch/`, `lazygit/`, `git/`, `opencode/` - CLI & system utilities

### 2. Home Dotfiles (`~/`)
* `.zshrc` - Shell configuration, custom functions (`check_disks`), aliases, and environment paths
* `.p10k.zsh` - Powerlevel10k prompt style settings
* `.bashrc` & `.profile` - Core shell startup scripts
* `.tmux.conf` - Multiplexer shortcuts and plugins
* `.XCompose` - Custom key character mappings

### 3. System-Wide Rules & Settings (`/etc/` & `/var/`)
Custom adjustments made to hardware and network behavior:
* `/etc/systemd/zram-generator.conf` - Custom 8GB zram configuration
* `/etc/fstab` - Swapfile mounts
* `/etc/udev/rules.d/99-power-profile.rules` - Automatic power profile switcher (Performance on AC, Balanced on battery)
* `/etc/udev/rules.d/99-wifi-powersave.rules` - WiFi powersave automation rules
* `/etc/systemd/network/10-wired.network` - Static IP address configuration (`10.40.24.124`)
* `/etc/systemd/network/15-wlan0-ap.network` - WiFi Access Point routing configuration
* `/var/lib/iwd/ap/hotspot.ap` - iwd wireless AP credentials

### 4. Package Lists & Custom Scripts
* `installed_packages.txt` - Lists all explicitly installed packages (`pacman -Qe`)
* `installed_aur_packages.txt` - Lists all AUR/custom packages installed (`pacman -Qem`)
* `share-wifi.sh` - Your custom hotspot management automation script

---

## ⚠️ Actions Required BEFORE Formatting

Before formatting your drive, copy these key files/folders to an external USB drive or cloud storage:

> [!IMPORTANT]
> **1. Push Your Dotfiles Repository:**
> Ensure all changes in `/home/ngl/dotfiles` are committed and pushed to your remote repository on GitHub. This includes the new `omarchy_backup/` folder with `omarchy_backup.zip`, the installer fixes, and this guide.
> 
> **2. Sync Your Obsidian Vault:**
> Ensure your Obsidian vault `/home/ngl/Documents/obsidian git sync/` is fully committed and pushed to your remote repository. This contains your full customization history under `900 System/omarchymyway/`.
>
> **4. Personal Data Folders:**
> Individually copy other folders that are too large to package in the configuration archive:
> * `/home/ngl/Projects/` (All development projects)
> * `/home/ngl/Documents/` (All documents/certificates)
> * `/home/ngl/Downloads/` (Any files you wish to keep)

---

## 🔄 Restoration Workflow (After Formatting)

Once you have installed a fresh instance of Omarchy Linux, follow these steps to restore your environment.

### Step 1: Clone Dotfiles and Unpack Backup
First, clone your dotfiles repository to your new home directory, then extract the backup zip archive:
```bash
# Clone the dotfiles repository
git clone git@github.com:hsami7/dotfiles.git ~/dotfiles

# Extract the configuration backup (replace date with your backup date if different)
unzip ~/dotfiles/omarchy_backup/omarchy_backup.zip -d ~/
```
This extracts the files into `~/omarchy_backup_2026-08-22/`.

### Step 2: Restore User Configurations
Move the configuration folders into your new `~/.config/` directory:
```bash
# Backup the default configs just in case
mkdir -p ~/.config/default_bak
mv ~/.config/{hypr,waybar,walker,mako,swayosd,omarchy} ~/.config/default_bak/

# Move custom configs
cp -r ~/omarchy_backup_2026-08-22/user_config/* ~/.config/
```

### Step 3: Restore Home Directory Dotfiles
Move the shell profiles and configs back to your home directory:
```bash
cp ~/omarchy_backup_2026-08-22/home_files/.* ~/
```

### Step 4: Install Your Packages
Your dotfiles repository contains a bootstrap script. Run it to install all basic command line tools, terminal plugins, and fonts:
```bash
chmod +x ~/dotfiles/install-using-yay.sh
~/dotfiles/install-using-yay.sh
```
*(Optional)* Compare your new system packages with `installed_packages.txt` to install any missing GUI apps or CLI utilities.

### Step 5: Restore System-Wide Configurations
Copy the hardware, udev, and networking configurations back to their respective `/etc` paths:

```bash
# 1. zram configuration
sudo cp ~/omarchy_backup_2026-08-22/system_config/zram-generator.conf /etc/systemd/
sudo systemctl daemon-reload
sudo systemctl restart systemd-zram-setup@zram0.service

# 2. Udev Rules
sudo cp ~/omarchy_backup_2026-08-22/system_config/udev_rules/* /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger

# 3. Networkd configurations
sudo cp ~/omarchy_backup_2026-08-22/system_config/networkd/* /etc/systemd/network/
sudo networkctl reload

# 4. iwd Wireless AP configurations
sudo mkdir -p /var/lib/iwd/ap
sudo cp -r ~/omarchy_backup_2026-08-22/system_config/iwd/ap/* /var/lib/iwd/ap/
sudo systemctl restart iwd
```

### Step 6: Recreate the 16GB Swap File
Since swap files cannot be backed up directly, recreate it on your new root partition:
```bash
# Create dedicated directory and allocate 16GB
sudo mkdir -p /swap
sudo fallocate -l 16G /swap/swapfile
sudo chmod 600 /swap/swapfile
sudo mkswap /swap/swapfile
sudo swapon /swap/swapfile

# Add/Verify entry in /etc/fstab:
# /swap/swapfile none swap defaults 0 0
```

### Step 7: Apply the Active Theme
To apply the **Ethereal** theme and make sure all configuration links are correctly resolved, run the `omarchy` command:
```bash
omarchy theme set "Ethereal"
omarchy refresh all
```
