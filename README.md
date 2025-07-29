# 🧊 NixOS Config by mrangames

Добро пожаловать в мой конфиг для [NixOS](https://nixos.org/) и [Home Manager](https://nix-community.github.io/home-manager/), настроенный под Wayland и Hyprland. Здесь хранятся мои системные и пользовательские настройки, разбитые по каталогам.

## 📁 Структура

```bash
nixos-config/
├── nixos/           # Системные настройки NixOS (configuration.nix и hardware-configuration.nix)
├── home/            # Конфигурации Home Manager для пользователя
│   ├── home.nix     # Главный файл Home Manager
│   └── dotfiles/    # Пользовательские конфиги (Hyprland, Waybar, Fish и т.д.)
└── README.md        # Этот файл

