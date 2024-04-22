{ pkgs, ... }:
let fallout = pkgs.fetchFromGitHub
  {
    owner = "shvchk";
    repo = "fallout-grub-theme";
    rev = "e8433860b11abb08720d7c32f5b9a2a534011bca";
    sha256 = "1cf0gd7gziw1j6kilhihpdlna6j1hhvpsgaxsmsqckjmc7igixls";
  };
in
{
  boot.loader = {
    grub = {
      enable = true;
      theme = fallout;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true ;
  };
}