{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        number = true;
        relativenumber = true;
        ignorecase = true;
        smartcase = true;
        scrolloff = 3;
      };

      globals.mapleader = " ";

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        lua.enable = true;
        markdown.enable = true;

        python = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
        };
      };

      lsp = {
        enable = true;
        formatOnSave = true;
      };

      autocomplete.nvim-cmp.enable = true;

      telescope.enable = true;
      git.gitsigns.enable = true;
      statusline.lualine.enable = true;
      comments.comment-nvim.enable = true;
      autopairs.nvim-autopairs.enable = true;
    };
  };

  home.packages = with pkgs; [
    python313
    ruff
    pyright
    ripgrep
    fd
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
