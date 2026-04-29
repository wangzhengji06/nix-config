{ nix-config, ... }:

{
  imports = with nix-config.nixosModules; [
    system
    wsl
    shell
    containers
  ];

  modules.system = {
    username = "wang";
    hostName = "work-wsl";
    timeZone = "Asia/Tokyo";
    defaultLocale = "en_US.UTF-8";
    stateVersion = "25.05";
  };
}
