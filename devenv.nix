# Guide: https://devenv.sh/basics/
# Docs:  https://devenv.sh/reference/options/
{ pkgs, ... }:
{

  languages.rust = {
    # https://github.com/cachix/devenv/blob/main/src/modules/languages/rust.nix
    enable = true;
    version = "latest"; # = nightly
  };
  languages.java.enable = true;

  packages = with pkgs; [
    gnumake
    deno
    sbt
    go-task
    nodejs
    python3
    cargo-make
    # adoptopenjdk-jre-bin
  ];

  env = {
    NODE_HOME = "${pkgs.nodejs}";
    # JAVA_HOME = "${pkgs.adoptopenjdk-jre-bin.home}";
  };
}
