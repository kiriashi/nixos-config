{
  lib,
  stdenv,
  sources,
  dpkg,
  autoPatchelfHook,
  nss,
  nspr,
  alsa-lib,
  openssl,
  webkitgtk_4_1,
}:

stdenv.mkDerivation {
  pname = "mihomo-party";
  version = sources.mihomo-party.version;

  src = sources.mihomo-party.src;

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];
  buildInputs = [
    nss
    nspr
    alsa-lib
    openssl
    webkitgtk_4_1
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r opt $out/opt
    cp -r usr/share $out/share
    substituteInPlace $out/share/applications/mihomo-party.desktop \
      --replace-fail "/opt/mihomo-party/mihomo-party" "mihomo-party"
    ln -s $out/opt/mihomo-party/mihomo-party $out/bin/mihomo-party
  '';
}