# Docs: https://devenv.sh/basics/
{ pkgs, ... }: {
  # Extend main devenv:
  imports = [ ./devenv.nix ];
  name = "tk test";

  languages = {
    # Docs: https://devenv.sh/languages/
    java.enable = true;
  };

  packages = with pkgs; [
    # Search for packages: https://search.nixos.org/packages?channel=unstable&query=cowsay
    # (note: this searches on unstable channel, be aware your nixpkgs flake input might be on a release channel)

    gnumake
    deno
    sbt
    go-task
    nodejs
    python3
    cargo-make
    adoptopenjdk-jre-bin
  ];

  env = {
    NODE_HOME = "${pkgs.nodejs}";
    # JAVA_HOME = "${pkgs.adoptopenjdk-jre-bin.home}";
  };
}
