{ 
  inputs,
  config,
  ...
}:

{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "${config.profile.homeDir}/.config/sops/age/keys.txt";

    secrets = { 
      mihomo-config = {
        format = "binary";
        sopsFile = ./mihomoConfig;
      };
    };
  };
}