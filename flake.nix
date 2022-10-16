{
  description = "My personal NixOS/Home-manager configurations";

  inputs = {
    nixpkgs = {
      url = github:nixos/nixpkgs/nixos-unstable;
    };
    nixos-cn = {
      url = github:nixos-cn/flakes;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = github:nix-community/emacs-overlay;
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

  outputs = inputs @ { self, nixpkgs, nixos-cn, emacs-overlay, home-manager, impermanence, musnix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
    user = "hertz";
  in {
    nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];
    nixosConfigurations = (
      import ./hosts/hix {
        inherit (nixpkgs) lib;
        inherit inputs user system nixos-cn emacs-overlay home-manager impermanence musnix;
      }
    );
  };
}
