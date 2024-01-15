{ inputs, config }:
{
  config = {
    allowUnfree = true;
    allowBroken = true;
  };
  overlays = [
    inputs.nur.overlay
  ];
}
