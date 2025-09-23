{ 
  pkgs, 
  ... 
}:

{
  environment.systemPackages = [ pkgs.poweralertd ];

  systemd.user.services = {
    poweralertd = {
      description = "UPower-powered power alerter.";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.poweralertd}/bin/poweralertd";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

}
