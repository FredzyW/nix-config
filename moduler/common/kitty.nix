{ pkgs, lib, myhostname, ... }:
{
  programs.kitty = {
    enable = true;
    font = if myhostname == "laptop" then {
      name = "FiraCode Nerd Font";
      size = 20;
    } else {
      name = "FiraCode Nerd Font";
      size = 18;
    };
    shellIntegration = {
      mode = "no-cursor";
    };
    theme = "Dracula";
    settings = {
      confirm_os_window_close = 2;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      enable_audio_bell = false;
    };
  };
}
