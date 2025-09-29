{
  lib,
  pkgs,
  config,
  ...
}:
{
  security.doas = {
    enable = true;
    wheelNeedsPassword = true;
    extraRules = [
      {
        users = [ "${config.profile.userName}" ];
        noPass = false;
        keepEnv = false;
        persist = true;
      }
    ];
  };

  environment.systemPackages = with pkgs; [ doas-sudo-shim ];
  programs.fish.shellAbbrs = {
    sudo = "doas";
  };
}
