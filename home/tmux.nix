{ pkgs, dotfiles, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      nord
    ];

    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      set -g default-command "$SHELL"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g prefix C-s
      set-option -g status-position top

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set -g status-left ' #S '
      set -g status-right ' %Y-%m-%d %H:%M '
      set -g status-style bg=default
    '';
  };
}
