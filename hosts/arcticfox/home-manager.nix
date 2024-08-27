{
  username,
  home,
  inputs,
}:
{
  useGlobalPkgs = true;
  useUserPackages = true;
  users.${username} = {
    imports = [ home.default ];
  };
  extraSpecialArgs = {
    inherit username;
  };
}
