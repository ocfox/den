let
  whitefox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+OUWVmeBKBnRQ+mBIbf+ImU5A7XbfiFV9XOCqx6esJ root@whitefox";
in
{
  "factorio.age".publicKeys = [ whitefox ];
}
