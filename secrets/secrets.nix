let
  whitefox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+OUWVmeBKBnRQ+mBIbf+ImU5A7XbfiFV9XOCqx6esJ root@whitefox";
  arcticfox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ9KEGxo7YLGX32rgawLeBVHvp4MhiSJMzK5/koJ2ygE";
  redfox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKF6T30FEnPyt8XA93tYbXd0teaxQlndXQnYmFSL2QMq";
in
{
  "factorio.age".publicKeys = [ whitefox ];
  "sing-box-uuid.age".publicKeys = [ arcticfox ];
  "sing-box-out.age".publicKeys = [ redfox ];
}
