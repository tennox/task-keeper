# Guide: https://devenv.sh/basics/
# Docs:  https://devenv.sh/reference/options/
{ pkgs, ... }:
{

  languages.rust = { # https://github.com/cachix/devenv/blob/main/src/modules/languages/rust.nix
    enable = true;
    version = "latest"; # = nightly
  };

  packages = with pkgs; [
    
  ];

  #env.VAR = ""; 

  enterShell = ''
    echo $VAR
  '';
}
