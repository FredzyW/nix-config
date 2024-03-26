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
    ./dwm.nix
    ../../common/kitty.nix
    ../../common/tmux.nix
    ./zsh.nix 
    ../../common/git.nix
    ../../common/nixpkgs.nix
    ../../common/firefox.nix
  ];

  home.packages = with pkgs; [
    networkmanager
    firefox
    mpv
    pavucontrol
    git
    alsa-utils
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
    yt-dlp
    python3
    python311Packages.pip

    #LSP
    nil
    python311Packages.python-lsp-server
    marksman
    clojure-lsp
    omnisharp-roslyn
    haskell-language-server
    java-language-server
    nodePackages_latest.bash-language-server
    dockerfile-language-server-nodejs
    yaml-language-server
    ansible-language-server
    lua-language-server

    #VPN
    openvpn
    networkmanagerapplet
    networkmanager-l2tp
    strongswan
    ansible

    #Funk
    cabal-install
    ghc
    haskellPackages.hoogle
    haskellPackages.fast-tags

    #Disk
    clojure
    leiningen

    # Jobb
    remmina
    dotnet-sdk_8
    mono5
    dotnetPackages.Nuget
  ];

  programs.home-manager.enable = true;

  home.username = "fw";
  home.homeDirectory = "/home/fw";

  home.stateVersion = "23.11"; # Did you read the comment?

  systemd.user.startServices = "sd-switch";
}
