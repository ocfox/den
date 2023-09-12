{ pkgs }:
pkgs.sway-unwrapped.overrideAttrs (old: {
  patches = old.patches or [ ] ++ [
    (pkgs.fetchpatch {
      url = "https://aur.archlinux.org/cgit/aur.git/plain/0001-text_input-Implement-input-method-popups.patch?h=sway-im&id=9bba3fb267a088cca6fc59391ab45ebee654ada1";
      hash = "sha256-xrBnQhtA6LgyW0e0wKwymlMvx/JfrjBidq1a3GFKzZo=";
    })

    (pkgs.fetchpatch {
      url = "https://aur.archlinux.org/cgit/aur.git/plain/0002-backport-sway-im-to-v1.8.patch?h=sway-im&id=9bba3fb267a088cca6fc59391ab45ebee654ada1";
      hash = "sha256-IpyipHgoXl7vVmBpBULiS6WtieMfkeARB+930Fl+51c=";
    })
  ];
})
