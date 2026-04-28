{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nixd
      nil
      statix
      deadnix
      stylua
      lua-language-server
      typescript-language-server
      vscode-langservers-extracted
      markdown-oxide
      ripgrep
      fd
    ];

    extraConfig = # vim
      ''
        filetype plugin indent on

        set undofile
        set number
        set relativenumber
        set linebreak
        set clipboard=unnamedplus
        set fileencoding=utf-8
        set fileencodings=utf-8,sjis
        set spelllang=en_us,cjk
        set noshowmode
        set mouse=a
        set ignorecase
        set smartcase
        set scrolloff=3
        set sidescrolloff=5
        set foldmethod=indent
        set foldlevelstart=99

        let mapleader = ' '

        nnoremap <leader>e :set nu! rnu!<CR>
        nnoremap <leader>g :set hlsearch!<CR>

        autocmd BufWritePre,FileWritePre * silent! call mkdir(expand(':p:h'), 'p')
      '';

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      gitsigns-nvim
      comment-nvim
      nvim-autopairs
      nvim-surround
      lualine-nvim
      nvim-web-devicons
      nvim-treesitter.withAllGrammars
      vim-nix
      fzf-vim
    ];

    extraLuaConfig = # lua
      ''
        require('gitsigns').setup()
        require('Comment').setup()
        require('nvim-autopairs').setup()
        require('nvim-surround').setup()
        require('lualine').setup()

        require('nvim-treesitter.configs').setup {
          highlight = { enable = true },
        }

        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local servers = {
          'nixd',
          'lua_ls',
          'ts_ls',
          'html',
          'cssls',
          'jsonls',
          'markdown_oxide',
        }

        for _, server in ipairs(servers) do
          vim.lsp.config[server] = { capabilities = capabilities }
          vim.lsp.enable(server)
        end

        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load()

        local cmp = require('cmp')
        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm { select = true },
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
          },
        }

        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          end,
        })
      '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
