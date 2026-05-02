{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  services.emacs = {
    enable = true;
    package = config.programs.emacs.finalPackage;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    nil
    nixfmt-rfc-style
  ];
}
