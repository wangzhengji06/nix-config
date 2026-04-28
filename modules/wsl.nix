{ config, ... }:

{
  wsl = {
    enable = true;
    defaultUser = config.modules.system.username;
    startMenuLaunchers = true;

    interop = {
      register = true;
      includePath = false;
    };

    wslConf = {
      automount = {
        enabled = true;
        root = "/mnt";
        options = "metadata,umask=22,fmask=11";
      };

      network = {
        generateHosts = true;
        generateResolvConf = true;
      };
    };
  };
}
