{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, tinycmmc }:
    tinycmmc.lib.eachWin32SystemWithPkgs (pkgs:
      {
        packages = rec {
          default = libmikmod;

          libmikmod = pkgs.stdenv.mkDerivation rec {
            pname = "libmikmod";
            version = "3.3.11.1";

            src = pkgs.fetchurl {
                    url = "mirror://sourceforge/mikmod/libmikmod-${version}.tar.gz";
              sha256 = "06bdnhb0l81srdzg6gn2v2ydhhaazza7rshrcj3q8dpqr3gn97dd";
            };

            cmakeFlags = [
              "-DENABLE_DSOUND=OFF"
              "-DENABLE_DOC=OFF"
            ];

            nativeBuildInputs = [
              pkgs.buildPackages.cmake
            ];
          };
        };
      }
    );
}
