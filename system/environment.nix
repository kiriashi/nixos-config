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
    curl
    wget
    python3
    nvfetcher
    nix-output-monitor
    wlr-randr
    xorg.xrandr

    unzip
    unrar
    p7zip
    zstd

    bibata-cursors
    adwaita-icon-theme
  ];

  environment.localBinInPath = true;

  environment.etc."bash".source = "${pkgs.bash}/bin/bash";
  environment.etc."bin/bash".source = "${pkgs.bash}/bin/bash";
  systemd.extraConfig = ''
    DefaultLimitNOFILE=262144
  '';
  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = 262144;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
