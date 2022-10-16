{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [ 
      epkgs.evil
      epkgs.emms
      epkgs.magit
    ];
    overrides = self: super: rec {
      haskell-mode = self.melpaPackages.haskell-mode;
    };
    extraConfig = ''
    '';
  };
  services.emacs = {
    enable = true;
    #package = 
    client = {
      enable = true;
      arguments = [ "-c" ];
    };
    defaultEditor = true;
    extraOptions = [ "f" "exwm-enable" ];
    socketActivation.enable = true;
    startWithUserSession = true;
  };

}
