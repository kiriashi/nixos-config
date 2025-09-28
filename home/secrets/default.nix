{ config, ... }:
{
  sops = {
    age.keyFile = "${config.profile.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;

    secrets = { 
    };
  };
}