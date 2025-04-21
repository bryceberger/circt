{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell.override {stdenv = pkgs.clangStdenv;} {
  name = "circt";

  nativeBuildInputs = with pkgs; [
    cmake
    mold-wrapped
    ninja
    z3
  ];
  packages = with pkgs; [
    clang-tools
    just
    (python3.withPackages (ps: with ps; [psutil]))
    sby
  ];

  env = {
    Z3LIB = "${pkgs.z3.lib}/lib/libz3.so";
  };
}
