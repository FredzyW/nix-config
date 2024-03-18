{ pkgs, lib, ... }:
{
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
}
