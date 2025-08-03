if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -Ux XCURSOR_THEME Bibata-Modern-Classic
set -Ux XCURSOR_SIZE 24
set -Ux XCURSOR_PATH /run/current-system/sw/share/icons:/usr/share/icons:/usr/share/pixmaps
set -Ux EDITOR nvim
set -Ux TERM kitty
if not set -q SSH_AUTH_SOCK
    set -Ux SSH_AUTH_SOCK (ssh-agent -c | grep SSH_AUTH_SOCK | cut -d ';' -f 1 | sed 's/setenv/set -x/' | source)
end

function backup-nixos-config
    set repo_dir ~/nixos-config

    echo "Копируем конфиги из системы в $repo_dir..."

    cp /etc/nixos/configuration.nix $repo_dir/nixos/configuration.nix
    cp /etc/nixos/hardware-configuration.nix $repo_dir/nixos/hardware-configuration.nix

    cp ~/.config/home-manager/home.nix $repo_dir/home/
    cp -r ~/.config/home-manager/dotfiles/* $repo_dir/home/dotfiles/

    echo "Готово! Теперь можно зайти в $repo_dir и сделать git commit/push."
end

function git-commit-push
    set repo_dir ~/nixos-config
    cd $repo_dir
    git pull
    echo "Изменения подтянуты"
    read -P "Комментарий к коммиту: " commit_msg

    if test -z "$commit_msg"
        echo "Ошибка: комментарий не может быть пустым!"
        return 1
    end

    set date (date "+%Y-%m-%d")
    set full_msg "$commit_msg ($date)"

    git add .
    git commit -m "$full_msg"
    git push
    echo "Коммит и пуш выполнены успешно!"
end
function saveclipimg
    set types (wl-paste --list-types)
    for type in $types
        switch $type
            case 'image/png'
                set ext png
            case 'image/jpeg'
                set ext jpg
            case 'image/bmp'
                set ext bmp
            case '*'
                continue
        end

        set filename ~/Pictures/(date "+%Y-%m-%d_%H-%M-%S").$ext
        wl-paste --type $type > $filename
        echo "Сохранил как $filename"
        return 0
    end

    echo "❌ В буфере нет изображения."
    return 1
end

