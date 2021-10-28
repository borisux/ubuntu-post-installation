#!/bin/bash
#
# Authors:
#  Boris
#
# Description:
#   A post-installation bash script for Ubuntu tested in 20.04.3

echo ''
echo '#---------------------------------------------------#'
echo '#  Ubuntu  Post-Installation Script  		          #'
echo '#---------------------------------------------------#'

#----- FUNCTIONS -----#

# SYSTEM UPGRADE
function sysupgrade {
# Perform system upgrade
echo ''
read -p 'Proceed with system upgrade? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Dist-Upgrade
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    sysupgrade
    ;;
esac
}


# INSTALL APPLICATIONS
function fav_apps {
# Install Favourite Applications
echo ''
echo 'Installing selected favourite applications...'
echo ''
echo 'Current package list:

openssh-server
ansible 
software-properties-common
git
filezilla 
curl 
net-tools(ifconfig)
java-jre
geany (IDE) 
arpscan 
couchdb
curl
filezilla
geany
geany-plugin-addons
geany-plugins
gimp
gimp-plugin-registry
synaptic 
terminator
gthumb - image viewer 
guake - terminal 
tmux
icontool
imagemagick
guake
terminator
vlc
openjdk-7-jdk | openjdk-8-jdk
openssh-server
python-pip
python3-distutils-extra
synaptic'
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    echo 'Requires root privileges:'
    # Add repositories
    # Update
    sudo apt-get update
    # Install.
    sudo apt install -y software-properties-common ansible git filezilla curl net-tools openssh-server  geany geany-plugins geany-plugin-addons arp-scan  geany geany-plugins geany-plugin-addons gimp gimp-plugin-registr synaptic terminator gthumb guake icontool tmux screen synaptic vlc python-pip python3-distutils-extra imagemagick sshpass
    
    if [ $(lsb_release -sr) = '12.04' ]; then
      sudo apt-get install openjdk-7-jdk
    elif [ $(lsb_release -sr) = '14.04' ]; then
      sudo apt-get install openjdk-7-jdk
    elif [ $(lsb_release -sr) = '16.04' ]; then
      sudo apt-get install openjdk-8-jdk
    elif [$(lsb_release -sr) = '20.04']; then 
      sudo apt install default-jre
    fi
    echo 'Enable ssh and allow in fw'
    sudo systemctl enable ssh
    sudo ufw allow ssh
    echo 'Verify that ssh is open and allowed in firewall'
    sudo systemctl list-unit-files | grep enabled | grep ssh
    echo 'Netstat SSH'
    netstat -tulpn | grep 22^
    sudo ufw status
    echo 'Do not forget to Disable Root Login (PermitRootLogin no)'
    echo 'Setting terminator as default terminal'
    gsettings set org.gnome.desktop.default-applications.terminal exec 'terminator'
    echo 'Changing background'
    if [ $(lsb_release -sr) = '12.04' ]; then
      gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Twilight_Frost_by_Phil_Jackson.jpg
    elif [ $(lsb_release -sr) = '14.04' ]; then
      gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Forever_by_Shady_S.jpg
    elif [ $(lsb_release -sr) = '16.04' ]; then
      gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/Spring_by_Peter_Apas.jpg
    elif [ $(lsb_release -sr) = '20.04' ]; then
      gsettings set org.gnome.desktop.background picture-urile:///usr/share/backgrounds/ubuntu-default-greyscale-wallpaper.png
    fi
    echo 'Defining git global for borisn'
     git config --global user.email "borisn@gmail.com"
     git config --global user.name "borisux"
     git config --global push.default simple
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    fav_apps
    ;;
esac
}

# CUSTOMIZATION
function customize {
echo ''
echo '1. Configure system?'
echo '2. Install Third-Party themes?'
echo 'r. Return'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
    1) clear && config;; # System Configuration
    2) clear && themes;; # Install Third-Party Themes
    [Rr]*) clear && main;; # Return
    * ) clear && echo 'Not an option, try again.' && customize;; # Invalid choice
esac
}

# THIRD PARTY APPLICATIONS
function thirdparty {
echo 'What would you like to install? '
echo ''
echo '1. Google Chrome?'
echo '2. Dropbox'
echo '3. VirtualBox'
echo '4. Vagrant'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Google Chrome
1)
    echo 'Downloading Google Chrome...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Google Chrome...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-chrome*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm google-chrome*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
#Dropbox
2)
    echo 'Downloading Dropbox...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.0_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.0_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Dropbox...'
    echo 'Requires root privileges:'
    sudo dpkg -i dropbox_1.6.0_*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm dropbox_1.6.0_*.deb
    cd
    nautilus -q
    echo 'Done.'
    thirdparty
     ;;   
# VirtualBox
3)
    echo 'Downloading VirtualBox '
    sudo apt install virtualbox virtualbox-ext-pack
    # Install package(s)
    echo 'Done.'
    thirdparty
    ;;
# Vagrant
4)
    echo "Installing Vagrant" 
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install vagrant
    ;;
# Return
[Rr]*)
    clear && main;;
# Invalid choice
* )
    clear && echo 'Not an option, try again.' && thirdparty;;
esac
}

# CLEANUP SYSTEM
function cleanup {
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove orphaned packages?'
echo '4. Remove leftover configuration files?'
echo '5. Clean package cache?'
echo 'r. Return?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Remove Unused Pre-installed Packages
1)
    echo 'Removing selected pre-installed applications...'
    echo 'Requires root privileges:'
    sudo apt-get purge landscape-client-ui-install ubuntuone-control-panel* overlay*
    echo 'Done.'
    cleanup
    ;;
# Remove Old Kernel
2)
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -v linux-libc-dev | xargs sudo apt-get -y purge
    echo 'Done.'
    cleanup
    ;;
# Remove Orphaned Packages
3)
    echo 'Removing orphaned packages...'
    echo 'Requires root privileges:'
    sudo apt-get autoremove -y
    echo 'Done.'
    cleanup
    ;;
# Remove residual config files?
4)
    echo 'Removing leftover configuration files...'
    echo 'Requires root privileges:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Done.'
    cleanup
    ;;
# Clean Package Cache
5)
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo apt-get clean
    echo 'Done.'
    cleanup
    ;;
# Return
[Rr]*)
    clear && main;;
# Invalid choice
* )
    clear && echo 'Not an option, try again.' && cleanup;;
esac
}

# Quit
function quit {
read -p "Are you sure you want to quit? (Y)es, (N)o " REPLY
case $REPLY in
    [Yy]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && echo 'Sorry, try again.' && quit;;
esac
}

#----- MAIN FUNCTION -----#
function main {
echo ''
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install third-party applications?'
echo '4. Cleanup the system?'
echo 'q. Quit?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
    1) sysupgrade;; # System Upgrade
    2) clear && fav_apps;; # Install Favourite Applications
    3) clear && thirdparty;; # Install Third-Party Applications
    4) clear && cleanup;; # Cleanup System
    [Qq]* ) echo '' && quit;; # Quit
    * ) clear && echo 'Not an option, try again.' && main;;
esac
}

#----- RUN MAIN FUNCTION -----#
main

#END OF SCRIPT



