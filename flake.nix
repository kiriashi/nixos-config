{
  description = "Self-using configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # niri-flake = {
    #   url = "github:sodiboo/niri-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };



outputs = 
  { 
    chaotic, 
    home-manager,  
    # niri-flake,
    nix-index-database, 
    nixpkgs, 
    self, 
    ... 
  } 
  @inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    myPkgs = import ./pkgs { inherit pkgs; };
    genRev = import ./modules/genRev.nix { inherit self; };
  in
  {
    packages.${system} = myPkgs;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs;
        myPkgs = self.packages.${system}; 
      };
      modules = [
        ./modules/system.nix
        ./modules/services.nix
        ./modules/RBP152022.nix

        (import ./overlays)

        # Chaotic软件源
        chaotic.nixosModules.default
        ({ lib, ... }: {
          chaotic.mesa-git.enable = true;
        })

        # Home Manager 配置
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."kiriashi".imports = [ ./modules/home.nix ];
          home-manager.extraSpecialArgs = { 
            inherit inputs;
            myPkgs = self.packages.${system}; 
          };
        }

        # niri-flake.nixosModules.niri
        #   ({ lib, ... }:{
        #     niri-flake.cache.enable = true;
        #     nixpkgs.overlays = [ niri-flake.overlays.niri ];
        #     services.gnome.gnome-keyring.enable = lib.mkForce false;
        #   })

        # nix-index 数据库
        nix-index-database.nixosModules.nix-index
        {
          programs.nix-index.enable = true;
          programs.nix-index-database.comma.enable = true;
        }

        # 加入版本信息
        genRev
      ];
    };
  };
}
