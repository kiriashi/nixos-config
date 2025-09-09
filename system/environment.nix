{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    uv
    jq
    gcc
    wget
    nvfetcher
    nix-output-monitor
    wlr-randr
    xorg.xrandr

    unzip
    unrar
    p7zip

    bibata-cursors
    adwaita-icon-theme
  ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
