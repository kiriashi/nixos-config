{ 
  description = "Self configuration."; 

  inputs = { 
    nixpkgs.url = "nixpkgs/nixos-unstable"; 

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = { 
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs"; 
    }; 

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
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  } 
  @inputs: 
  let 
    system = "x86_64-linux"; 
    pkgs = nixpkgs.legacyPackages.${system};  
    selfPkgs = import ./pkgs { inherit pkgs; }; 
  in 
  { 
    packages.${system} = selfPkgs; 

    nixosConfigurations = { 
      laptop = nixpkgs.lib.nixosSystem { 
        inherit system; 
        specialArgs = { 
          inherit inputs; 
          selfPkgs = self.packages.${system}; 
        }; 
        modules = [ 
          ./modules/config.nix 
          ./modules/laptop.nix 
          ./modules/profile/laptop.nix 

          (import ./overlays) 
          ./modules/outputs/chaotic.nix
          ./modules/outputs/niri-flake.nix
          ./modules/outputs/nix-index.nix

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
                selfPkgs = self.packages.${system}; 
              }; 
            }; 
          }) 
        ]; 
      }; 
    }; 
  }; 
} 
