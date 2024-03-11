# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    arion
    wget
    pavucontrol
    alsa-utils
    killall
    upower
    dwmblocks
    mpv
    git
    gcc
    gnumake
    htop
    openssh
    xsel
    unzip
    nixops_unstable
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # FIXME: Add the rest of your current configuration
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;
  environment.sessionVariables = {
    EDITOR  = "lvim";
    TERM = "xterm-256color";
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  fonts.packages = with pkgs; [
    (nerdfonts.override { 
      fonts = [ 
        "FiraCode" 
        "DroidSansMono" 
      ]; 
    })
  ];


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # TODO: Set your hostname
  networking.hostName = "nix-desktop";

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;
  console.keyMap = "sv-latin1";
  programs.zsh.enable = true;

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      # FIXME: Replace with your username
      fw = {
        initialPassword = "password";
        isNormalUser = true;
        description = "Fredrik Wastring";
        extraGroups = [ 
          "networkmanager" 
          "wheel"
          "audio" 
          "docker"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDALsdpwvC0w/Aj+1fWtzJyyWoUrGkdh8o2thVHeQQBNo0D7cmVberYmi4Cv9gWGX6PaElrnOl0KRdGyro2wxOYokSxgk2VgWW67BFITAQAbKyG2NhXXPbhb4jccDo7WH7TtOG8IofuJTPRu1Duda6k4RN0I0CkyAN6LGX+zy49cq0qKf9ijXYhCDYNih3+Fu/ig0aW/SYmsVoUl2VFTWdI5x5/wLvIjTEZhmAtYIeYADaLnom356cFrUysZa++FUujQAz3Ow236BvP95XZdTsqvfWNZFNIpC9VYF72JeIDCs5wDIr0GFmanF2On1nar+jJpoOE8SdHt357p5g/PqXV5TisN2xQRkqVwO9tWtMl4sF84jA4ULnY2gQWv9jErMxymUQ1IwuPUzDDlbRHCtfexAtkBy7wv6xslKAzG1QahvF/btNs5Caj3LN31rgAuxyooCbKGKTeBP3kHPKcz1iupgidfbO/QqVXBRQJTEdGyAKa8hVmLQZZPC/XUhxESAk= fw@fw-nix"
        ];
      };
    };
  };

  services = {
    openssh = {
      enable = true;
    };
    blueman = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "se";
      xkbVariant = "";
      dpi = 140;
      displayManager = {
        startx = {
         enable = true;
        };
      };
      windowManager = {
        dwm = {
          enable = true;
        };
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
