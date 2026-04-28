# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "lzabry";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  networking.hostName = "home-wsl";
  
  # Set your time zone
  time.timeZone = "Asia/Tokyo";


  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };
  # Optimize storage
  # You can also manually optimize the store via:
  # nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;


  users.users.lzabry = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    nix-ld # to enable 3rd party binary
    podman
    docker
    unstable.go
  ];

  programs.nix-ld.enable = true;
  services.openssh.enable = true;

  # container
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  # openssh
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication= false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
