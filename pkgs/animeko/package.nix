{
  fetchurl,
  appimageTools,
  vlc,
}:

let
  version = "4.8.2";

  appimage = fetchurl {
    url = "https://github.com/open-ani/animeko/releases/download/v${version}/ani-${version}-linux-x86_64.appimage";
    sha256 = "sha256-I088DNHYZEf19x9Sv0NVFrqs+ip0AhB1otDyksoqX9U=";
  };
in

appimageTools.wrapType2 {
  pname = "animeko";
  inherit version;
  src = appimage;

  extraPkgs = pkgs: [
    vlc
  ];
}
