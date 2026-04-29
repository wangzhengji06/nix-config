{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.${config.modules.system.username}.extraGroups = [
    "docker"
    "podman"
  ];

  environment.systemPackages = with pkgs; [
    docker-compose
    podman-compose
  ];
}
