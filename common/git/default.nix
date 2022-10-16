{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Hertz Hwang";
    userEmail = "hertz@26hz.com.cn";
    extraConfig = { init = { defaultBranch = "main"; }; };
  };

}
