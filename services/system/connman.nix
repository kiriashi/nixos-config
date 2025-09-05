{ 
  pkgs, 
  lib, 
  ...
}:

{
  networking = {
    networkmanager.enable = lib.mkForce false;
    wireless = {
      enable = lib.mkForce false;
      iwd.enable = lib.mkForce true;
    };
  };

  services.connman = {
    enable = true;
    enableVPN = true;
    wifi.backend = "iwd";
    extraConfig = "
      [General]
      AllowHostnameUpdates=false
    ";
  };

  environment.systemPackages = with pkgs; [ connman-gtk ];
}
