{ 
  inputs,
  config,
  ...
}:

{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  
  home.file = {
    "id_ed25519.pub" = {
      source = ./id_ed25519.pub;
      target = ".ssh/id_ed25519.pub";
    };
  };

  sops = {
    age.keyFile = "${config.profile.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;

    secrets = { 
      id_ed22519 = {
        format = "binary";
        sopsFile = ./id_ed25519;
        path = "${config.profile.homeDir}/.ssh/id_ed25519";
      };

      ssh-config = {
        format = "binary";
        sopsFile = ./ssh_config;
        path = "${config.profile.homeDir}/.ssh/config";
      };

      # mihomo-config = {
      #   format = "binary";
      #   sopsFile = ./mihomo_config;
      #   path = "${config.profile.homeDir}/.config/mihomo/mihomo.yaml";
      # };
    };
  };
}