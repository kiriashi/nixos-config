{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    jq
    age
    git
    wget
    just
    sops
    nvfetcher
    nix-output-monitor

    unzip
    unrar
    p7zip
  ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    EDITOR = "hx";    
  };
}
