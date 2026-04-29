{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # core tools
      fd
      ripgrep
      tree-sitter
      git
      gcc
      gnumake
      unzip
      curl

      # runtimes
      nodejs
      python313

      # LSP servers
      lua-language-server
      nil
      basedpyright
      ruff
      typescript-language-server
      vscode-langservers-extracted
      bash-language-server
      yaml-language-server
      dockerfile-language-server-nodejs
      docker-compose-language-service
      sqls


      # formatters / linters
      stylua
      nixfmt-rfc-style
      prettier
      shfmt
      shellcheck
      checkmake

      # DAP
      python313Packages.debugpy
    ];
  };

  xdg.configFile."nvim".source = inputs.dotfiles;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
