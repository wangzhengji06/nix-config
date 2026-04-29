{ lib, config, pkgs, ... }:

let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) str;
  cfg = config.modules.system;
in
{
  options.modules.system = {
    username = mkOption {
      type = str;
      default = "user";
      description = "Primary user name.";
    };

    hostName = mkOption {
      type = str;
      default = "nixos";
      description = "System host name.";
    };

    timeZone = mkOption {
      type = str;
      default = "Asia/Tokyo";
      description = "System time zone.";
    };

    defaultLocale = mkOption {
      type = str;
      default = "en_US.UTF-8";
      description = "Default locale.";
    };

    stateVersion = mkOption {
      type = str;
      default = "25.05";
      description = "NixOS and Home Manager state version.";
    };
  };

  config = {
    networking.hostName = cfg.hostName;

    time.timeZone = cfg.timeZone;

    i18n.defaultLocale = cfg.defaultLocale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ja_JP.UTF-8";
      LC_IDENTIFICATION = "ja_JP.UTF-8";
      LC_MEASUREMENT = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
      LC_NAME = "ja_JP.UTF-8";
      LC_NUMERIC = "ja_JP.UTF-8";
      LC_PAPER = "ja_JP.UTF-8";
      LC_TELEPHONE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
    };

    nix = {
      package = pkgs.nixVersions.latest;

      settings = {
        auto-optimise-store = true;
        warn-dirty = false;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          "@wheel"
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    users.users.${cfg.username} = {
      isNormalUser = true;
      uid = 1000;
      description = cfg.username;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      sharedModules = [
        inputs.nvf.homeManagerModules.default

        {
          home = {
            username = cfg.username;
            homeDirectory = "/home/${cfg.username}";
            stateVersion = cfg.stateVersion;
          };

          programs.home-manager.enable = true;
          programs.man.generateCaches = true;
        }
      ];
    };

    system.stateVersion = cfg.stateVersion;
  };
}
