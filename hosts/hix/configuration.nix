{ lib, config, pkgs, inputs, ... }:

let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    sha256 = "0hpp8y80q688mvnq8bhvksgjb6drkss5ir4chcyyww34yax77z0l";
  };
in
{
  imports =
    [ 
      ./hardware-configuration.nix
      "${impermanence}/nixos.nix"
    ];

  boot = {
    supportedFilesystems = [ "zfs" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    #kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostId = "a73fc6f9";
    hostName = "hix";
    useDHCP = false;
    networkmanager.enable = true;
  };

  users = {
    mutableUsers = false;
    users = {
      hertz = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "users" "audio" ];
        initialHashedPassword = "$6$tdnBTo5ZGx1Sprin$ceT9r2b2SWq9tDOGWdGJ5yGk4KiyJ9MGBNOUycEBBRsEPSU1e7h/w.xg6PBDsZKFHKGCJQu7ersf7ofjCratn1";
        shell = pkgs.zsh;
        packages = with pkgs; [
          #firefox
        ];
      };
      root = {
        initialHashedPassword = "$6$x3CsIKfJgYYEloRp$8ptg.adJSFzmwqwC4jiBzkBDF/4ZZAxiU3Bh2f5EoDmghSIo42PBrcNhIUCfEtkjNFHEHHUeZjamzs2ExjMJi/";
      };
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime ];
    };
  };

  time = {
    timeZone = "Asia/Shanghai";
  };

  console = {
    font = "ter-i22b";
    packages = with pkgs; [ terminus_font ];
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      sarasa-gothic
      ubuntu_font_family
      jetbrains-mono
      noto-fonts-emoji
      (
        nerdfonts.override {
          fonts = [
            "FiraCode"
          ];
        }
      )
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Sarasa Fixed SC" ];
        sansSerif = [ "Sarasa Fixed SC" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
      localConf = ''
        <match>
          <test compare="contains" name="lang">
            <string>zh_CN</string>
          </test>
          <edit mode="prepend" name="family">
            <string>Sarasa Fixed SC</string>
          </edit>
        </match>
      '';
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };

  zramSwap.enable = true;

  environment = {
    persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/ssh"
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/var/log"
        "/var/lib/cups"
        "/var/lib/fprint"
        "/var/db/sudo/lectured"
      ];
      files = [
        "/etc/machine-id"
        "/etc/nix/id_rsa"
      ];
    };
    systemPackages = with pkgs; [
      vim
      wget
      git
      ntfs3g
      firefox
    ] ++ (with libsForQt5; [
      ark
      kate
      kcalc
      kmousetool
      krdc
    ]);
  };

  programs = {
    zsh.enable = true;
    kdeconnect.enable = true;
    partition-manager.enable = true;
    fuse.userAllowOther = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      max-jobs = "auto";
      substituters = lib.mkBefore [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://nixos-cn.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  security = {
    rtkit.enable = true;
    sudo.enable = true;
    doas = {
      enable = true;
      #wheelNeedsPassword = true;
      extraConfig = ''
        permit keepenv nopass :wheel
        # permit keepenv persist :wheel
      '';
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      config.pipewire = {
        "context.properties" = {
          "link.max-buffers" = 16;
          "log.level" = 2;
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 8192;
        };
      };
    };
    openssh = {
      enable = true;
    };
    usbmuxd = {
      enable = true;
    };
    colord = {
      enable = true;
    };
  };

  system.stateVersion = "22.11";

}


