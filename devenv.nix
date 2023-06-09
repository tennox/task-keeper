# Docs: https://devenv.sh/basics/
{ pkgs, ... }: {

  languages = {
    # Docs: https://devenv.sh/languages/
    nix.enable = true;
    rust = {
      enable = true; # https://github.com/cachix/devenv/blob/main/src/modules/languages/rust.nix
      version = "latest"; # = nightly
    };
      
    # for tests
    java.enable = true;
  };

  packages = with pkgs; [
    # Search for packages: https://search.nixos.org/packages?channel=unstable&query=cowsay
    # (note: this searches on unstable channel, be aware your nixpkgs flake input might be on a release channel)
    cargo-watch

    # for tests:
    gnumake
    deno
    sbt
    go-task
    nodejs
    python3
    cargo-make
    #adoptopenjdk-jre-bin
  ];

  env = {
    NODE_HOME = "${pkgs.nodejs}";
    # JAVA_HOME = "${pkgs.adoptopenjdk-jre-bin.home}";
  };

  difftastic.enable = true; # https://devenv.sh/integrations/difftastic/

  pre-commit.hooks = {
    # Docs: https://devenv.sh/pre-commit-hooks/
    # available pre-configured hooks: https://devenv.sh/reference/options/#pre-commithooks
    # adding hooks which are not included: https://github.com/cachix/pre-commit-hooks.nix/issues/31
    nil.enable = true; # nix check
    nixpkgs-fmt.enable = true; # nix formatting

    clippy.enable = true;
    #cargo-check.enable = true; ← if you don't want clippy
  };
}
