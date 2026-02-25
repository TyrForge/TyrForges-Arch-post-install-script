#!/bin/bash

# 1. Enable Multilib (Required for Steam)
echo "Enabling multilib repository..."
sudo sed -i '/\[multilib\]/,/Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf

# 2. Update System
echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing Pipewire and Wireplumber..."
sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    wireplumber \
    lib32-pipewire \
    lib32-pipewire-jack


echo "Installing Gamemode and Wine..."
sudo pacman -S --needed --noconfirm \
    gamemode \
    lib32-gamemode \
    wine-staging \
    winetricks \
    wine-gecko \
    wine-mono

echo "Installing Codecs..."
sudo pacman -S --needed --noconfirm \
    ffmpeg \
    vlc \
    vlc-plugins-all \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-ugly \ \
    gst-libav

# 3. Install KDE Plasma & SDDM
echo "Installing Desktop Enviroment and Minimal Requirements..."
sudo pacman -S --needed --noconfirm \
    plasma-desktop \
    sddm \
    sddm-kcm \
    dolphin \
    konsole \
    ark \
    gwenview \
    power-profiles-daemon \
    flatpak \
    discover \
    packagekit-qt6

# 4. Install Apps (Steam, Discord, etc.)
echo "Installing Applications..."
sudo pacman -S --needed --noconfirm \
    steam \
    discord \
    firefox \
    base-devel \
    git

# 5. Enable Services
echo "Enabling Services..."
sudo systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service

# 6. Optional: Install an AUR Helper (yay)
echo "Installing yay (AUR helper)..."
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay

echo "Finalizing..."
sudo systemctl --now enable sddm.service
sudo reboot

