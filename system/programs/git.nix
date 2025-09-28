{ 
  pkgs, 
  ... 
}:

{
  environment.systemPackages = [
    pkgs.git-credential-keepassxc
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential = {
      helper = "libsecret";
      credentialStore = "cache";
    };
  };

}
