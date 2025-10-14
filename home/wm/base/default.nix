{
  lib,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./fuzzel.nix
    ./mako.nix
    ./swayidle.nix
    ./theme.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    pwvucontrol
    brightnessctl
    libnotify

    wl-clipboard
    xclip
    cliphist

    swww
    mpvpaper
    waypaper

    socat

    self.wallpapers
  ];

  home.file.wallpapers = {
      source = "${pkgs.self.wallpapers}/share/Wallpapers";
      target = "Pictures/ Wallpapers";
  };
}
