{ pkgs, lib, ... }:
{
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
}
