{
  fetchFromGitHub,
  sing-box,
}:

sing-box.overrideAttrs (oldAttrs: rec {
  version = "1.14.0";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    tag = "v${version}";
    hash = "sha256-1v9bgM2H439ZoSkomv5dmT5SNrkuyOJ1iFFPlYPsW/k=";
  };

  vendorHash = "sha256-Bl73SkmnOyh5kULctDaxcOzXsYXRY2DOt80ME2+lBJo=";
})
