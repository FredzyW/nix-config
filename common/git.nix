{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "FredzyW";
    userEmail = "fredrik@wastring.com";
  };
}
