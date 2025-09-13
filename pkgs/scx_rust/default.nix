{ lib, stdenv, rustPlatform, fetchurl, sources, pkg-config, clang, llvm, makeWrapper }:

rustPlatform.buildRustPackage rec {
  pname = "scx_rust";
  version = sources.scx.version;
  src = sources.scx.src;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = [
    pkg-config
    clang
    llvm
    makeWrapper
  ];

  postPatch = ''
    substituteInPlace meson.build \
      --replace "/bin/bash" "${lib.getExe stdenv.shell}"
    patchShebangs meson-scripts
  '';

  buildPhase = ''
    cargo build --release
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/scx_* $out/bin/
  '';

  meta = with lib; {
    description = "sched_ext (scx) schedulers for Linux";
    homepage = "https://github.com/sched-ext/scx";
    license = licenses.gpl2;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}