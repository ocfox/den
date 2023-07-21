{ username
, home
, inputs
}:
{
  useGlobalPkgs = true;
  useUserPackages = true;
  users.${username} = {
    imports = [
      home.default
      home.desktop
    ];
  };
  extraSpecialArgs = { inherit username; };
}
