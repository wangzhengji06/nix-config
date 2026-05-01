{
  nix-config,
  config,
  ...
}: let
  username = config.modules.system.username;
in {
  home-manager.users.${username} = {
    imports = with nix-config.homeModules; [
      fish
      tmux
      neovim
      bat
      eza
      fzf
      git
      ripgrep
      zoxide
      emacs
    ];

  programs.git = {
    userName = "b-zhengji.a.wang";
    userEmail = "b-zhengji.a.wang@rakuten.com";
    };
  };
}
