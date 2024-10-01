{ inputs }:
{
  config = {
    allowUnfree = true;
    allowBroken = true;
  };
  overlays = [
    inputs.self.overlays.default
  ];
}
