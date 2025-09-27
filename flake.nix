{
  description = "Self configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    niri-flake.url = "github:sodiboo/niri-flake";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


outputs = 
  { 
    chaotic,
    home-manager,  
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

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs;
          myPkgs = self.packages.${system}; 
        };
        modules = [
          (import ./overlays)
          ./modules/config.nix
          ./modules/laptop.nix
          ./modules/profile/laptop.nix

          # Chaotic软件源
          chaotic.nixosModules.default
          ({ lib, ... }: {
            chaotic.mesa-git.enable = true;
          })
          # Home Manager 配置
          home-manager.nixosModules.home-manager
          ({ config, ... }: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [ ./modules/profile/laptop.nix ];
              users.${config.profile.userName}.imports = [ ./home ];
              extraSpecialArgs = {
                inherit inputs;
                myPkgs = self.packages.${system}; 
              };
            };
          })
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
  };
}
