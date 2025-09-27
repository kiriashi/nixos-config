{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    uv
    jq
    python3
    nvfetcher
    nix-output-monitor

    unzip
    unrar
    p7zip
  ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "2";
  };
}
