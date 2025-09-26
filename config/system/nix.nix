{ 
  pkgs,
  config,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "mihomo-party"
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--delete-older-than 7d --keep 5";
    };
    flake = "/home/${config.profile.userName}/Documents/Git/nixos";
  };  

  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "${config.profile.userName}"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      builders-use-substitutes = true;
      keep-derivations = true;
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirrors.sustech.edu.cn/nix-channels/store"
        # "https://mirrors.sjtug.edu.cn/nix-channels/store"

        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  system = {
    stateVersion = "25.11";
    autoUpgrade.channel = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable";
  };

}