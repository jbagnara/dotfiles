# DUNNO IF THIS WORKS

echo "Are you running as root?[Y/n]\n"
read response
if [ $response != "Y" ] then
    echo "Must be run as root\n"
    exit 1
fi

echo "Enter username\n"
read response

useradd -m -G wheel $response
echo "Enter password for user $response"
passwd $response

pacman -S sudo
echo "Add the wheel group to sudo config..."
sleep 5
visudo

su $response

sudo pacman -S \
    sway \
    swaybg \
    swayidle \
    make \
    git \
    firefox \
    go \
    openssh \
    python-pip \
    pulseaudio \
    pipewire \
    pavucontorl \
    fuzzle \
    wl-clipboard \
    noto-fonts \
    nodejs \
    clangd

pip3 install \
    i3ipc

git clone https://aur.archlinux.org/yay-git.git /tmp/yay-git
pushd /tmp/yay-git
makepkg -si
popd

yay \
    termite \
    waybar \
    swaylock-effects-git \
    ttf-noto-emoji-monochrome

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
