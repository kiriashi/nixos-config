{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      splayer
      qqmusic
      pliplus
      bilibili
      ffmpeg
      nomacs
      imagemagick
      inkscape-with-extensions
      pwvucontrol
    ];
  };

  programs = {
    mpv = {
      enable = true;

      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-text-pthread
        obs-vkcapture
        wlrobs
        input-overlay
      ];
    };

  };
}