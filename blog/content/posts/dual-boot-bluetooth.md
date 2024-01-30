---
title:  "Bluetooth Pairing on Dual Boot"
date: "2022-11-23"
tags: ["bluetooth"]
summary: "Edit pairing keys on Windows and Linux, make they are consistent"
---

## Dual Boot Bluetooth

When pair your device, Bluetooth service generates a unique set of pairing keys.
So twice pair will generate two differen keys.
Simplely synchronizing two pairing keys can solve it.

## Sync pairing keys

- Pair device once on Windows and Linux.
- Mount Windows system partition on Linux.
- Use [chntpw](http://pogostick.net/~pnh/ntpasswd/) to change the pairing key in Windows.

Get the pairing key
```fish
cat /var/lib/bluetooth/<current_computer_bluetooth_mac>/<device_mac>/info 

...
[LinkKey]
key=YOURDEVICEPAIRINGKEY
...
```

```
chntpw -e WIN_PATH/Windows/System32/config/SYSTEM

> l
Node has 17 subkeys and 0 values
  key name
  <ActivationBroker>
  <ControlSet001>
  <DriverDatabase>
  <HardwareConfig>
  <Input>
...
```
Replace ControlSetXXX with the value of your system.
```
cd ControlSet001\Services\BTHPORT\Parameters\Keys
```

```
(...)\Services\BTHPORT\Parameters\Keys> l 
Node has 2 subkeys and 0 values
  key name
  <144f8a...>
  <35d48b...>
```
Edit Windows pairing key

```
> cd <computer_bluetooth_mac>
> l
(...)\BTHPORT\Parameters\Keys\<computer_bluetooth_mac> > l
Node has 0 subkeys and 1 values
  size     type              value name             [value if type DWORD]
    16  3 REG_BINARY         <25f3e8ad4ce5>
    16  3 REG_BINARY         <device_mac>
```
Don't forget add space
```
ed <device_mac>
.: 0 YO UR DE VI CE PA IR IN GK EY
.s
> q
```

Reboot, and now there is no need to pair again after each system switching.
