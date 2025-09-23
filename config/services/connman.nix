{ 
  pkgs, 
  ...
}:

{
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