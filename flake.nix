{
  description = "My personal NixOS with Flakes&Home-manager configurations";

  inputs = {
    nixpkgs = {
      url = github:nixos/nixpkgs/nixos-unstable;
    };
    nixos-cn = {
      url = github:nixos-cn/flakes;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = github:nix-community/impermanence;
    };
    musnix = {
      url = github:musnix/musnix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixos-cn, home-manager, impermanence, musnix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
    user = "hertz";
  in {
    nixosConfigurations = {
      hix = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/hix/configuration.nix
          nixos-cn.nixosModules.nixos-cn-registries
          nixos-cn.nixosModules.nixos-cn
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit user;
              };
              users.${user} = {
                home.stateVersion = "22.11";
                home.homeDirectory = "/home/${user}";
                imports = [ "${impermanence}/home-manager.nix" (import ./common/home.nix) ];
              };
            };
          }
          musnix.nixosModules.musnix {
            musnix = {
              enable = true;
              alsaSeq.enable = false;
            };
          }
        ];
      };
    };
  };
}
