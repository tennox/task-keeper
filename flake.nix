{
  description = "virtual environments";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-utils, devshell, nixpkgs, rust-overlay, crane }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (import rust-overlay)
            devshell.overlays.default
          ];
        };

        # rustToolchain = pkgs.rust-bin.stable.latest.default.override {
        #   targets = [ "wasm32-wasi" ];
        # };
        rustToolchain = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
          # extensions = [ "rust-src" ];
          targets = [
            "x86_64-unknown-linux-musl"
            #  "wasm-unknown-unknown" 
          ];
        });

        craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;

        my-crate = craneLib.buildPackage {
          # https://crane.dev/getting-started.html
          src = craneLib.cleanCargoSource (craneLib.path ./.);

          CARGO_BUILD_TARGET = "x86_64-unknown-linux-musl";
          CARGO_BUILD_RUSTFLAGS = "-C target-feature=+crt-static";
          # Add extra inputs here or any other derivation settings
          # doCheck = true;
          # buildInputs = [];
          # nativeBuildInputs = [];
        };
      in
      {
        checks = {
          inherit my-crate;
        };

        packages.default = my-crate;

        devShell = pkgs.devshell.mkShell {
          devshell.packages = [ rustToolchain ] ++ (with pkgs; [
            nixpkgs-fmt
          ]);

          # # ? Not sure if needed
          # env = /* nixpkgs.lib.trace "${rust}/lib/rustlib/src/rust/library" */ [
          #   { name = "RUST_SRC_PATH"; value = "${rust}/lib/rustlib/src/rust/library"; }
          # ];
        };
      });
}
