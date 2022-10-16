{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit";
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;
    #cdpath = [];
    defaultKeymap = "emacs";
    dirHashes = {
      docs  = "$HOME/Documents";
      vids  = "$HOME/Videos";
      dl    = "$HOME/Downloads";
    };
    dotDir = ".config/zsh";
    #envExtra = ""; #Extra commands that should be added to .zshenv
    #initExtra = ""; #Extra commands that should be added to .zshrc
    #localVariables = {};
    #loginExtra = {};
    #logoutExtra = {};
    #profileExtra = {};
    #sessionVariables = { MAILCHECK = 30; };
    shellAliases = {
      cdconf = "cd $HOME/nixland";
      nixupdate = "nix flake update";
      nixupgrade = "doas nixos-rebuild switch --flake .#hix";
      fars = "curl -F 'c=@-' 'https://fars.ee/' <";
      gaa = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend -m";
      gpl = "git pull";
      gph = "git push";
      gco = "git checkout";
      gst = "git status";
      glog = "git log --pretty=format:'%C(auto)%h %ad | %C(auto)%s%d %Cblue(%an)' --graph --date=short";
    };
    plugins = [
      {
        name = "doas";
        src = pkgs.fetchFromGitHub {
          owner = "monesonn";
          repo = "doas.zsh";
          rev = "11ead2969f7466439351e18f1059a8c1abeb244d";
          sha256 = "1fz1h3kq7ch9slk534vyxkjilvyag83xp2049rk1crngh6ia2hhm";
        };
      }
    ];
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.config/zsh/history";
    };
#    oh-my-zsh = {
#      enable = true;
#      #custom = "PATH";
#      plugins = [ "git" ];
#      #theme = "agnoster";
#      extraConfig = ''
#      '';
#    };
  };
}

