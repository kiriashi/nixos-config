{ 
  inputs,
  config,
  ...
}:

{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  
  sops = {
    age.keyFile = "${config.profile.homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;

    secrets = { 
    };
  };
}