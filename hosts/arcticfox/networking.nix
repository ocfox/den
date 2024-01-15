{
  firewall.enable = false;
  hostName = "arcticfox";

  useDHCP = false;
  
  interfaces.eno1.useDHCP = true;
  interfaces.eno2.useDHCP = true;
  interfaces.eno3.useDHCP = true;
  interfaces.eno4.useDHCP = true;
}
