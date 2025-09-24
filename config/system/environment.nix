{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fastfetch
    busybox
    git
    uv
    jq
    gcc
    wget
    killall
    python3
    gnumake
    nvfetcher
    nix-output-monitor
    wlr-randr

    unzip
    unrar
    p7zip
  ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
