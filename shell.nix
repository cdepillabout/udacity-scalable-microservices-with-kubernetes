
let
  src = builtins.fetchTarball {
    # nixpkgs master as of 2020-07-17
    url = https://github.com/NixOS/nixpkgs/archive/e6d81a9b89e8dd8761654edf9dc744660a6bef0a.tar.gz;
    sha256 = "0lmw1zy00l89b0x7l5f85bvxdd2w245iqf9smyiyxvl1j03b0zyq";
  };
in

with import src {};

stdenv.mkDerivation {
  name = "kubernetes-practice-env";

  nativeBuildInputs = [
    go
  ];

  buildInputs = [
  ];

  shellHook = ''
    export GOPATH="$(pwd)"
  '';

  # These phases need to be set to noops so this shell file can actually be
  # built with `nix-build shell.nix`.
  unpackPhase = "true";
  installPhase = "touch $out";

  # Set Environment Variables
  #RUST_BACKTRACE = 1;
}

