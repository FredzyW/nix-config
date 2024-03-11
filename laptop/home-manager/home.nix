# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../common/dwm-2.nix
    ./zsh.nix
  ];

  config.nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    firefox
    thunderbird
    scrot
    feh
    kitty
    dunst
    xbanish
    neovim
    neofetch
    spotify
    dmenu
    signal-desktop
    brightnessctl
    tmux
    zathura
    lunarvim
    obsidian
    darktable
    lazygit
    discord
    slack
  ];
  programs.home-manager.enable = true;

  xsession.enable = true;
  xsession.windowManager.command = "exec dwm";

  home.username = "fw";
  home.homeDirectory = "/home/fw";

  programs.firefox = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    plugins = with pkgs; [
      {
        name = "zsh-z";
        file = "zsh-z.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/agkozak/zsh-z";
          rev = "afaf2965b41fdc6ca66066e09382726aa0b6aa04";
        };
      }
    ];
    profileExtra = "
      if [[ -z $DISPLAY ]]; then
        exec startx
      fi
    ";
    shellAliases = {
      ls="ls --color=auto";
      ll="ls -al --color=auto";
      ccr="gcc intopt.c && ./a.out";
      update="sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
      nixc="lvim ~/nix-config/laptop/nixos/configuration.nix";
      reb="sudo nixos-rebuild switch --flake '.#nix-laptop'";
      homec="lvim ~/nix-config/laptop/home-manager/home.nix";
      home="home-manager switch --flake '.#fw@nix-laptop'";
      sdg="sudo nix-collect-garbage -d";
      udg="nix-collect-garbage -d";
      df="df -h";
      c="clear";
    };
    enableCompletion = true;
    initExtraBeforeCompInit = ''
    # Lines configured by zsh-newuser-install
    HISTFILE=~/.histfile
    HISTSIZE=1000
    SAVEHIST=1000
    setopt autocd extendedglob
    bindkey -v
    bindkey '^R' history-incremental-search-backward
    bindkey '^[[1;5C' emacs-forward-word
    bindkey '^[[1;5D' emacs-backward-word
    # End of lines configured by zsh-newuser-install
    # The following lines were added by compinstall
    zstyle :compinstall filename '/home/fw/.zshrc'

    # autoload -Uz compinit
    autoload -U compinit; compinit
    zstyle ':completion:*' menu select

    '';
    initExtra = "
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      export PATH=/home/fw/.local/bin:$PATH
      source ~/programs/powerlevel10k/powerlevel10k.zsh-theme
    ";
  };

  programs.yt-dlp = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 22;
    };
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    theme = "Catppuccin-Macchiato";
    settings = {
      confirm_os_window_close = 2;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      enable_audio_bell = false;
    };
  };

  programs.git = {
    enable = true;
    userName = "FredzyW";
    userEmail = "fredrik@wastring.com";
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      tmuxPlugins.sessionist
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes 'lvim'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-restore 'on'
        '';
      }
    ];
    prefix = "C-a";
    terminal = "xterm-256color";
    keyMode = "vi";
    extraConfig = "
      set -g message-style 'fg=#24273a,bg=#abb1bb'
      set -g message-command-style 'fg=#24273a,bg=#abb1bb'
      set -g pane-border-style 'fg=#abb1bb'
      set -g pane-active-border-style 'fg=#81a1c1'
      set -g status-style 'fg=#81a1c1,bg=#24273a'

      set -g popup-style 'bg=#242932'
      set -g popup-border-style 'bg=#242932,bg=#242932'

      setw -g window-status-style 'NONE,fg=#7e8188,bg=#24273a'
      setw -g window-status-activity-style 'underscore,fg=#7e8188,bg=#24273a'

      setw -g window-status-format '#[fg=#24273a,bg=#24273a,nobold,nounderscore,noitalics]#[default] #I #W #F #[fg=#24273a,bg=#24273a,nobold,nounderscore,noitalics]'
      setw -g window-status-current-format '#[fg=#24273a,bg=#e5e0fa,nobold,nounderscore,noitalics]#[fg=#7e62e5,bg=#e5e0fa,bold] #I \ #W #F #[fg=#e5e0fa,bg=#24273a,nobold,nounderscore,noitalics]'

      set -g status-left '#[fg=#7e62e5,bg=#e5e0fa,bold] #S #[fg=#e5e0fa,bg=#24273a,nobold,nounderscore,noitalics]'
      set -g status-right ''
    ";
  };
  home.stateVersion = "23.11"; # Did you read the comment?

  systemd.user.startServices = "sd-switch";
}
