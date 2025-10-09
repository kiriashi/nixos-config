{ 
  description = "Kiriashi's Nixos configuration."; 

  inputs = { 
    nixpkgs.url = "nixpkgs/nixos-unstable"; 

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; 

    niri-flake.url = "github:sodiboo/niri-flake";

    zen-browser = { 
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs"; 
    }; 

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
      RBP15-2022 = nixpkgs.lib.nixosSystem { 
        inherit system; 
        specialArgs = { 
          inherit inputs selfPkgs; 
        }; 
        modules = [
          ./modules/options/laptop.nix 
          ./modules/RBP15-2022.nix 
          ./modules/system.nix 
          
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
              sharedModules = [ ./modules/options/laptop.nix ]; 
              users.${config.profile.userName}.imports = [ ./home ];
              extraSpecialArgs = { inherit inputs selfPkgs; }; 
            }; 
          }) 
        ]; 
      }; 
    }; 
    
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        just
        nix-output-monitor
        age
        sops
        nvfetcher
      ];
    };
  }; 
}