{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    dist = {
      url = "github:caddyserver/dist";
      flake = false;
    };
    caddy-tailscale = {
      url = "github:tailscale/caddy-tailscale";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      systems,
      dist,
      caddy-tailscale,
    }:
    flake-utils.lib.eachSystem (import systems) (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.callPackage (import ./package.nix {
          inherit dist caddy-tailscale;
        }) { };

        # devShells.default = pkgs.mkShell {
        #   buildInputs = [
        #   ];
        # };
      }
    );
}
