{ pkgs, lib, ... }:
let
  dwm = pkgs.dwm.overrideAttrs (old: {
    src = builtins.fetchGit {
      url = "https://github.com/FredzyW/dwm-conf.git";
      rev = "99a1e812295bcf65625a4b5a0dc1022658977920";
    };
    nativeBuildInputs = with pkgs; [ 
      xorg.libX11.dev
      xorg.libXft
      imlib2
      xorg.libXinerama
    ];
  });
  dwmblocks = pkgs.dwmblocks.overrideAttrs (old: {
    src = builtins.fetchGit {
      url = "https://github.com/FredzyW/dwmblocks.git";
      rev = "a334789ec7b9171a3c8e1fcac2ffe8463ee438dc";
      
    };
  });
in
{
  home.packages = [ dwm dwmblocks ];
}

