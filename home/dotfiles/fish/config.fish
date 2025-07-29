if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -Ux XCURSOR_THEME Bibata-Modern-Classic
set -Ux XCURSOR_SIZE 24
set -Ux XCURSOR_PATH /run/current-system/sw/share/icons:/usr/share/icons:/usr/share/pixmaps
set -Ux EDITOR nvim
set -Ux GTK_IM_MODULE fcitx
set -Ux QT_IM_MODULE fcitx
set -Ux XMODIFIERS "@im=fcitx"
set -Ux INPUT_METHOD fcitx
set -Ux SDL_IM_MODULE fcitx
set -Ux GLFW_IM_MODULE fcitx
set -Ux TERM kitty
function runserver
    cp /home/mrangames/IdeaProjects/SigmaPLugin/build/libs/SigmaPLugin-1.0-SNAPSHOT.jar ~/paper-server/plugins/
    cd ~/paper-server
    java -Xmx2G -jar paper-1.21.8-11.jar nogui
end
function mcmanager
   cd /opt/mcsmanager/mcsmanager/
   pkill -f ./start-daemon.sh
   pkill -f ./start-web.sh
   sudo bash ./start-daemon.sh  
   sudo bash ./start-web.sh
   xdg-open 'http://localhost:23333'

end
if not set -q SSH_AUTH_SOCK
    set -Ux SSH_AUTH_SOCK (ssh-agent -c | grep SSH_AUTH_SOCK | cut -d ';' -f 1 | sed 's/setenv/set -x/' | source)
end

function backup-nixos-config
    set repo_dir ~/nixos-config

    echo "Копируем конфиги из системы в $repo_dir..."

    cp /etc/nixos/flake.nix $repo_dir/
    cp /etc/nixos/flake.lock $repo_dir/

    cp /etc/nixos/configuration.nix $repo_dir/hosts/nixos.nix
    cp /etc/nixos/hardware-configuration.nix $repo_dir/hardware/

    cp ~/.config/home-manager/home.nix $repo_dir/home/
    cp -r ~/.config/home-manager/dotfiles/* $repo_dir/home/dotfiles/

    echo "Готово! Теперь можно зайти в $repo_dir и сделать git commit/push."
end

