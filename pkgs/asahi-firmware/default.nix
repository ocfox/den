{ stdenv, fetchzip }:

stdenv.mkDerivation {
  pname = "asahi-firmware";
  version = "1.0";

  src = fetchzip {
    url = "https://transfer.ocfox.me/QO/asahi.tar.gz";
    hash = "sha256-fpI3PILAb7LT8BC9Q97U44Sv1/LWeDV6gGxvXsc7L4s=";
  };

  installPhase = ''
    mkdir -p $out
    cp * $out
  '';
}
