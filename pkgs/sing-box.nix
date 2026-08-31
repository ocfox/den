{
  fetchFromGitHub,
  sing-box,
}:

sing-box.overrideAttrs (oldAttrs: rec {
  version = "1.14.0-rc.5";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    tag = "v${version}";
    hash = "sha256-zEMkYK/MZHSQT8ih8zPoeooyuWlXSCi9TLlnP86eGvQ=";
  };

  vendorHash = "sha256-37zjqQSdib8vNmHifFx0zeZq6ipTig0u2CUY2z2kToU=";
})
