{
  programs.git = {
    enable = true;
    userName  = "kiriashi";
    userEmail = "2244193927@qq.com";
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
    };
  };
}