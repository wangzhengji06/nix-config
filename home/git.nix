{
  programs.git = {
    enable = true;

    userName = "wangzhengji06";
    userEmail = "wangzhengji06@gmail.com";

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
