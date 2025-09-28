{ config, ... }:
{
  sops = {
    enable = true;
    age.keyFile = "${config.profile.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;

    secrets = { 
    };
  };
}