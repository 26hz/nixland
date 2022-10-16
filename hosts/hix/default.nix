{ lib, inputs, system, nixos-cn, home-manager, impermanence, user, musnix, ... }:

{
  hix = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user inputs;
    };
    modules = [
      ./configuration.nix
      ({ ... }: {
        # 使用 nixos-cn flake 提供的包
        environment.systemPackages = [
          #nixos-cn.legacyPackages.${system}.netease-cloud-music
        ];
        imports = [
          # 将nixos-cn flake提供的registry添加到全局registry列表中
          # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
          nixos-cn.nixosModules.nixos-cn-registries

          # 引入nixos-cn flake提供的NixOS模块
          nixos-cn.nixosModules.nixos-cn
        ];
      })
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
            imports = [ "${impermanence}/home-manager.nix" (import ../../common/home.nix) ];
          };
        };
      }
      musnix.nixosModules.musnix {
        #environment.systemPackages = with pkgs; [ pavucontrol libjack2 jack2 qjackctl jack2Full jack_capture ];
        musnix = {
          enable = true;
          alsaSeq.enable = false;
        };
      }
    ];
  };
}
