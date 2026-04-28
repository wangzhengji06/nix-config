{ nix-config, ... }:

{
  imports = with nix-config.nixosModules; [
    system
    wsl
    shell
  ];

  modules.system = {
    username = "lzabry";
    hostName = "home-wsl";
    timeZone = "Asia/Tokyo";
    defaultLocale = "en_US.UTF-8";
    stateVersion = "25.05";
  };
}
