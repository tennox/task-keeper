# Setting up a devenv

1. Install [nix](https://github.com/DeterminateSystems/nix-installer) (or install the required dependencies yourself, but for e.g. tests, there are a lot)
2. Install direnv (optional, recommended for ease of use)
3. Run `direnv allow` / `nix develop --impure`

### Tests

```bash
# enter shell:
nix develop --impure .#test
# run directly:
nix develop --impure .#test -c cargo test
```