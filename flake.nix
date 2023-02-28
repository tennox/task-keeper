{
  description = "virtual environments";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, flake-utils, devshell, nixpkgs, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let
          pkgs = import nixpkgs {
            inherit system;

            overlays = [
              (import rust-overlay)
              devshell.overlays.default
            ];
          };
          rust = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
            extensions = [ "rust-src" ];
            # targets = [ "wasm-unknown-unknown" ];
          });
        in
        pkgs.devshell.mkShell {
          devshell.packages = with pkgs; [
            # TODO rust-bin.fromRustupToolchainFile ./rust-toolchain
            rust
            nixpkgs-fmt
          ];

          # ? Not sure if needed
          env = /* nixpkgs.lib.trace "${rust}/lib/rustlib/src/rust/library" */ [
            { name = "RUST_SRC_PATH"; value = "${rust}/lib/rustlib/src/rust/library"; }
          ];
        };
    });
}
