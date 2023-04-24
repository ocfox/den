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
      home.darwin
    ];
  };
  extraSpecialArgs = { inherit username; };
}
