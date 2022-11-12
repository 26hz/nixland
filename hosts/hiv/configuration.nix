{ lib, config, pkgs, inputs, system, ... }:

let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    sha256 = "1xj0s2qj7xcq1zai6diymfza7mxwhizw1akxz392nv39az71yn24";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${impermanence}/nixos.nix"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hiv"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime ];
    };
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
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.colord.enable = true;
  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.initialHashedPassword = "$6$jjMzmucC0DEns/EJ$89cxnruCo4svbLhl2o5kEbNaxdTjEofzxxYCY72x7SHGqUzLiN.jUt1pBfEbxLNo/vmHiyWi3bnPkSTJx6V9R1";
  users.users.hertz.initialHashedPassword = "$6$/XvcuMvhfoJBX.Xd$tIciFFJiCVmvZr7NeedJVPE2O4NNNMsunBcyp529nswm9T2AJtiyGKoEqz/KLYX96nM/tf7ruDC6VxV8n6Prr.";
  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;
  users.users.hertz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "users" "audio" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      #firefox
    ];
  };
  programs.zsh.enable = true;
  security = {
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gptfdisk
    nix-prefetch-git
    nix-prefetch-scripts
    manix
    killall
    usbutils
    ntfs3g
    xorg.xhost
    kalendar
    kcolorchooser
    helvum
    libimobiledevice
    ifuse
  ] ++ (with libsForQt5; [
    ark
    kate
    kcalc
    kmousetool
    krdc
  ]);
  services.usbmuxd.enable = true;
  #environment.etc."machine-id".source
    #= "/nix/persist/etc/machine-id";
  #environment.etc."ssh/ssh_host_rsa_key".source
    #= "/nix/persist/etc/ssh/ssh_host_rsa_key";
  #environment.etc."ssh/ssh_host_rsa_key.pub".source
    #= "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
  #environment.etc."ssh/ssh_host_ed25519_key".source
    #= "/nix/persist/etc/ssh/ssh_host_ed25519_key";
  #environment.etc."ssh/ssh_host_ed25519_key.pub".source
    #= "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
  programs.fuse.userAllowOther = true;
  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

