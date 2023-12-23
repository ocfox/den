{ inputs, config }:
{
  config = {
    allowUnfree = true;
    allowBroken = true;
  };
  overlays = [
    inputs.nur.overlay
    (self: super: {
      factorio = super.factorio.override {
        username = "ocfox";
        token = builtins.readFile config.age.secrets.factorio.path;
        versionsJson = inputs.factorio-versions.versions;
      };
    })
  ];
}
