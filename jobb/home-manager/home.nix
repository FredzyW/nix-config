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
    ../../common/kitty.nix
    ../../common/tmux.nix
    ../../common/git.nix
    ../../common/nixpkgs.nix
    ../../common/firefox.nix
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
    lsof
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
    yt-dlp
    imagemagick
    # VPN
    networkmanagerapplet
    networkmanager-l2tp
    strongswan
    ansible
    # Jobb
    slack
    azure-cli
    remmina
    infisical
    vscode
    vscode-extensions.ms-dotnettools.csharp
    netcoredbg
    dotnet-sdk_8
    mono5

    dotnetPackages.Nuget
  ];
  programs.home-manager.enable = true;

  xsession.enable = true;
  xsession.windowManager.command = "exec dwm";

  home.username = "fw";
  home.homeDirectory = "/home/fw";

  home.stateVersion = "23.11"; # Did you read the comment?

  systemd.user.startServices = "sd-switch";
}
