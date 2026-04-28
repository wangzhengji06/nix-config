{ nix-config, config, ... }:

let
  username = config.modules.system.username;
in
{
  home-manager.users.${username} = {
    imports = with nix-config.homeModules; [
      fish
      neovim
      tmux
      bat
      eza
      fzf
      git
      ripgrep
    ];
  };
}
