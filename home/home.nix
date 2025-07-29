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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    hello
    hyprpaper


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
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
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mrangames/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    IMAGE_VIEWER = "imv";

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
