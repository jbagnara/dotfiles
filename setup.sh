## DUNNO IF THIS WORKS
#
#echo "Are you running as root?[Y/n]\n"
#read response
#if [ $response != "Y" ] then
#    echo "Must be run as root\n"
#    exit 1
#fi
#
#echo "Enter username\n"
#read response
#
#useradd -m -G wheel $response
#echo "Enter password for user $response"
#passwd $response
#
#pacman -S sudo
#echo "Add the wheel group to sudo config..."
#sleep 5
#visudo
#
#su $response
#
sudo pacman -S \
    sway \
    swaybg \
    swayidle \
    make \
    firefox \
    go \
    python-pip \
    pavucontrol \
    fuzzel \
    wl-clipboard

yay \
    termite \
    waybar \
    swaylock-effects-git

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
