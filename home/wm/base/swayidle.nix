{
  pkgs,
  ...
}:

{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "lock";
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors && ${pkgs.gtklock}/bin/gtklock -d";
      }
      {
        event = "unlock";
        command = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }
      {
        event = "after-resume";
        command = "${pkgs.gtklock}/bin/gtklock -d";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors && ${pkgs.gtklock}/bin/gtklock -d";
      }
    ];
  };
}
