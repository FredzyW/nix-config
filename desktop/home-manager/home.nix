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
    # inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

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
    gimp
    openssh
    yt-dlp
    hugo
    flameshot
    # inputs.nix-gaming.packages.${pkgs.system}.wine-tkg
    # lutris
  ];

  programs.home-manager.enable = true;

  home.username = "fw";
  home.homeDirectory = "/home/fw";

  home.stateVersion = "23.11"; # Did you read the comment?

  systemd.user.startServices = "sd-switch";
}
