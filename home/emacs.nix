{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  home.packages = with pkgs; [
    emacs-nox
    ripgrep
    fd
    nil
    nixfmt-rfc-style
  ];
}
