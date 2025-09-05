{ 
  pkgs, 
  ... 
}:

{
  environment.systemPackages = with pkgs; [
    swww
    mpvpaper
    waypaper
    socat
  ];

  # systemd.user.services = {
  #   swww = {
  #     description = "Efficient animated wallpaper daemon for wayland, controlled at runtime.";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       ExecStart = "${pkgs.swww}/bin/swww-daemon";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

}
