{ 
  pkgs, 
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "kiriashi"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      builders-use-substitutes = true;
      keep-derivations = true;
      substituters = [
        "https://nix-community.cachix.org"

        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # "https://mirrors.sustech.edu.cn/nix-channels/store"
        # "https://mirrors.sjtug.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

}
