{ username
, home-manager
, inputs
}:
{
  useGlobalPkgs = true;
  useUserPackages = true;
  users.${username} = {
    imports = [
      home-manager
      inputs.hyprland.homeManagerModules.default
    ];
  };
  extraSpecialArgs = { inherit username; };
}
