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
    ../../common/dwm.nix
    ../../common/kitty.nix
    ../../common/tmux.nix
    ../../common/zsh.nix {
      hostname = "nix-desktop";
      username = "fw";
      directory = "desktop";
    }
    ../../common/git.nix
    ../../common/nixpkgs.nix
    ../../common/firefox.nix
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
  ];

  programs.home-manager.enable = true;

  home.username = "fw";
  home.homeDirectory = "/home/fw";

  home.stateVersion = "23.11"; # Did you read the comment?

  systemd.user.startServices = "sd-switch";
}
