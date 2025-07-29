{ config, lib, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> { system = builtins.currentSystem; };

  stylix = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/stylix/archive/ea60526c8c2a1c5df2743a9495814dc0b319ef3b.tar.gz";
    sha256 = "159s98gn59xg51s38p63inj7j3c7plv59a3cc0kwvncy8faq21gf";
  });
in
{
  imports = [
    ../hardware-configuration.nix
    stylix.nixosModules.stylix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes"; # или "prohibit-password"
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # hardware.opengl has beed changed to hardware.graphics
  #services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.nvidia.modesetting.enable = true;

  #hardware.opengl.enable = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Omsk";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "ru_RU.UTF-8" "en_US.UTF-8" ];
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];

  services.xserver.enable = true;
  services.xserver = {
    xkb.layout = "us,ru";
    xkb.variant = "";
    xkb.options = "grp:alt_shift_toggle";
  };

  services.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "mrangames";
  };
  services.displayManager.defaultSession = "hyprland";
  programs.hyprland.enable = true;

  services.libinput.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs.fish.enable = true;

  users.users.mrangames = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/mrangames";
    password = "root";
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };

  services.xserver.desktopManager.xterm.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    libreoffice-qt6-fresh
    gnome-tweaks gnome-terminal
    bibata-cursors
    mesa libdrm vulkan-tools
    firefox obs-studio
    amnezia-vpn telegram-desktop
    hyprpaper cartero pipes
    ayugram-desktop
    speedtest-cli
    neofetch fastfetch pfetch
    flatpak rofi wofi
    gimp kitty htop unzip curl fish
    spotify ufetch cowsay lolcat
    virtualbox prismlauncher
    python311
    (python311.withPackages (ps: with ps; [
      fastapi uvicorn pydantic requests
    ]))
    waybar
    font-awesome
    power-profiles-daemon
    nerd-fonts._3270
    playerctl
    brightnessctl
    swayws
    bottom
    cava
    neovim
    ranger
    git
    papirus-icon-theme
    gtk3
    doas
    grim
    slurp
    wl-clipboard
    pulseaudio
    linuxHeaders
    gnome-boxes
    kvmtool
    libvirt
    qemu
    virt-manager
    libsForQt5.qt5.qtgraphicaleffects
    plymouth
    wofi-power-menu
    wofi-emoji
    obsidian
    nerd-fonts.jetbrains-mono
    imagemagick
    imv
    neohtop
    wlsunset
    bat
    libnotify
    nodejs 
    ripgrep
    fd 
    vimPlugins.LazyVim
    home-manager
    spicetify-cli
    ninvaders
    tetris
    nyancat
    stylix
    catppuccin-grub
    jdk21_headless
    vulkan-loader
    vulkan-tools
    steam
    lsof
    openssh
    dig
    gobuster
    telegram-desktop
    yt-dlp
    ffmpeg
    home-manager
    pavucontrol
    kdePackages.dolphin
    mako
    hyprpicker
    hyprlock
    hypridle
    hyprsysteminfo
    hyprsunset
    hyprcursor
    wl-clipboard
    hyprshot
    cliphist
    noto-fonts-cjk-sans
    meslo-lg
    tg
    dua
    libsForQt5.kde-cli-tools
    kdePackages.kde-cli-tools
    emacs
    speedtest-go
    apktool
    jadx
    apksigner
    rustc
    cargo
    oniux
  ];



  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
localNetworkGameTransfers.openFirewall = true;
    
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam" "steam-original" "steam-unwrapped" "steam-run"
    ];

  programs.gamemode.enable = true;

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    VK_ICD_FILENAMES = "/etc/vulkan/icd.d/amd_icd64.json";
    VK_LAYER_PATH = "/etc/vulkan/explicit_layer.d";
  };

  programs.firefox.enable = true;
  programs.amnezia-vpn.enable = true;

  virtualisation.virtualbox.host.enable = true;
  boot.kernelModules = [ "vboxdrv" ];
  virtualisation.libvirtd.enable = true;

  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "loglevel=0" "udev.log_level=0" ];
  boot.plymouth.enable = true;

  system.stateVersion = "25.05";

  stylix = {
    enable = false;

    fonts = {
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };

    targets = {
      console.enable = true;
      grub.enable = true;
      plymouth.enable = true;
    };
  };
}

