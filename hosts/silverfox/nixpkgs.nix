{ inputs, config }:
{
  overlays = [ inputs.self.overlays.default ];
  config = {
    allowUnfree = true;
    allowBroken = true;
  };
}
