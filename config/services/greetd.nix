{
  pkgs,
  config,
  ...
}:

{
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = initial_session;
      initial_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -r --user-menu --remember-session --time --time-format '%Y-%m-%d %l:%M:%S'";
        # command = "${pkgs.niri-unstable}/bin/niri-session";
        user = "${config.profile.userName}";
      };
    };
  };

}
