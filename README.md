# Конфигурация NixOS и Home Manager от MrAngames

Это репозиторий с моими конфигурациями для NixOS и Home Manager.  
Здесь хранятся системные конфиги и пользовательские dotfiles.

---

## Структура репозитория

- `hosts/nixos.nix` — основная конфигурация NixOS  
- `hardware/hardware-configuration.nix` — конфигурация оборудования  
- `home/home.nix` — конфигурация Home Manager для пользователя  
- `home/dotfiles/` — папка с dotfiles (fish, hyprland, waybar и др.)  
- `flake.nix` и `flake.lock` — flake-конфигурация

---

## Использование

### Клонирование и установка (для новой или существующей системы)

```bash
git clone git@github.com:MrAngames/NixOS-configuration.git ~/nixos-config
cd ~/nixos-config

sudo nixos-rebuild switch --flake .#nixos
home-manager switch --flake .#mrangames
