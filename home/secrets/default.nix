{ config, ... }:
{
  home.file = {
    "id_ed25519.pub" = {
      source = ./id_ed25519.pub;
      target = ".ssh/id_ed25519.pub";
    };
  };

  sops = {
    age.keyFile = "${config.profile.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;

    secrets = { };
  };
}