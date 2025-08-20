{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mrangames";
  home.homeDirectory = "/home/mrangames";
  home.enableNixpkgsReleaseCheck = false;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/waybar/config.json".source = ./dotfiles/waybar/config.json;
    ".config/hypr/hyprland.conf".source = ./dotfiles/hyprland/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ./dotfiles/hyprland/hyprpaper.conf;
    ".config/wofi/config".source = ./dotfiles/wofi/config;
    ".config/wofi/style.css".source = ./dotfiles/wofi/style.css;
    ".config/kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
    ".config/fish/config.fish".source = ./dotfiles/fish/config.fish;
    ".config/mako/config".source = ./dotfiles/mako/config;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.file.".mozilla/firefox/4z1wawum.default" = {
    source = "/persist/firefox-profile";
    recursive = true;
  };

  programs.git = {
    enable = true;
    userName = "MrAngames";
    userEmail = "andrucreatinggames@gmail.com";
    extraConfig = {
	init.defaultBranch = "main";
	pull.rebase = false;
    };

  };

  programs.waybar = {
    enable = true;
    style = /home/mrangames/.config/home-manager/dotfiles/waybar/style.css;
  };
  nixpkgs.config.allowUnfree = true;
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-airline
      tokyonight-nvim	
      nerdtree
      nvim-tree-lua
      vim-devicons
      coc-nvim
      nvim-treesitter
      #copilot-vim
      plenary-nvim
      vim-wakatime
      oil-nvim
    ];

  extraConfig = ''
    syntax on
    colorscheme tokyonight
    set number
    set tabstop=4
    set shiftwidth=4
    set expandtab
    nnoremap <C-n> :NERDTreeToggle<CR>

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    inoremap <silent><expr> <Tab>
          \ coc#pum#visible() ? coc#pum#next(1) :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()

    inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

    inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
    '';
  };


  fonts.fontconfig.enable = true;
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png"  = [ "vlc.desktop" ];
      "image/jpeg" = [ "vlc.desktop" ];
      "image/webp" = [ "vlc.desktop" ];
      "image/gif"  = [ "vlc.desktop" ];
    };
  };


  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    IMAGE_VIEWER = "vlc";

  };

  programs.home-manager.enable = true;
}
