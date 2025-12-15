{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "lxgw-zhisong";
  version = "0.515";

  src = fetchurl {
    url = "https://github.com/lxgw/LxgwZhiSong/releases/download/v${version}/LXGWZhiSongMN.ttf";
    hash = "sha256-llzn+lRYmYPazsmaYO4/vMwOUSH1B4PAHNIt2o8yqDU=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm444 "$src" "$out/share/fonts/truetype/LXGWZhiSongMN.ttf"

    runHook postInstall
  '';
}
