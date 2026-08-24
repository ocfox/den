{
  fetchFromGitHub,
  sing-box,
}:

sing-box.overrideAttrs (oldAttrs: rec {
  version = "1.14.0-rc.1";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    tag = "v${version}";
    hash = "sha256-SMFPB3ab2Y/Aakbgnaz1iDp0ZF+iHE3BOvoRojII9Cc=";
  };

  vendorHash = "sha256-ea9oaMryf4qEc3bjkEzFN+Rt8djnhM8AqmKUG65xCVc=";
})
