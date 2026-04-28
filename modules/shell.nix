{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;

  environment = {
    shells = with pkgs; [ fish ];

    systemPackages = with pkgs; [
      bash
      coreutils
      curl
      fd
      file
      findutils
      git
      gnugrep
      gnused
      gnutar
      gzip
      jq
      less
      man-pages
      nix-tree
      nvd
      ripgrep
      rsync
      statix
      tree
      unzip
      wget
      which
      xh
      zip
    ];
  };

  programs = {
    fish.enable = true;
    neovim.enable = true;
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
