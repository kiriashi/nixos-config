{
  pkgs,
  config,
  ...
}:

{
  environment.systemPackages = with pkgs; [ steam-run ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    extraPackages = with pkgs; [
      zulu8
    ];
    extraCompatPackages = with pkgs; [
      proton-cachyos_x86_64_v4
      proton-ge-custom
      luxtorpeda
    ];
  };

  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope_git;
    args = [
      "-F fsr"
      "--fsr-sharpness 7"
      "-W 2560"
      "-H 1440"
      "-f"
      "--rt"
      "--adaptive-sync"
      "--immediate-flip"
      "--force-grab-cursor"
      "--backend auto"
    ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send '游戏模式已开启' && ${pkgs.mako}/bin/makoctl mode -a do-not-disturb";
        end = "${pkgs.mako}/bin/makoctl mode -r do-not-disturb && ${pkgs.libnotify}/bin/notify-send '游戏模式已关闭'";
      };
    };
  };

  users.users.${config.profile.userName}.extraGroups = [ "gamemode" ];

  hardware.steam-hardware.enable = true;

}
