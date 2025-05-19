#
# Maintainer:
#       Caolan o'Domhnaill
# Purpose: For use with Ubuntu non-gui install on VMWare
#
# setup the GUI
sudo apt install ubuntu-desktop; sudo apt install gdm3; sudo systemctl set-default graphical

# Install desktop VMWare tools
sudo apt install open-vm-tools-desktop
sudo reboot now
