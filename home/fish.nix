{
  programs.fish = {
    enable = true;

    shellInit = # fish
      ''
         set -U fish_greeting ""

         set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
         set -x -U LESS_TERMCAP_me (printf "\e[0m")
         set -x -U LESS_TERMCAP_se (printf "\e[0m")
         set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
         set -x -U LESS_TERMCAP_ue (printf "\e[0m")
         set -x -U LESS_TERMCAP_us (printf "\e[01;32m")
         set -x -U MANROFFOPT "-c"

         fish_default_key_bindings
      '';

    shellAliases = {
      tree = "eza --all --long --tree";
      mv = "mv -i";
      cp = "cp -ia";
      ls = "eza --group-directories-first";
      ll = "eza --all --long --group-directories-first";
    };

    shellAbbrs = {
      nf = "nix flake";
      nfc = "nix flake check";
      nfu = "nix flake update";
      nb = "nix build";
      ns = "nix shell";
      nr = "nix run";
      nd = "nix develop --command fish";
      ncg = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      nvd = "nvd --color always diff /run/current-system result | rg -v 0.0.0 | less -R";
      sw = "sudo nixos-rebuild switch --flake .#home-wsl";

      c = "clear";
      e = "exit";
      l = "ls -l";
      n = "nvim";
      t = "tmux";
      jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";
    };
  };
}
