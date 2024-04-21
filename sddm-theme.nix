{pkgs}:
let
    background = pkgs.fetchurl {
        url = "https://get.wallhere.com/photo/1680x1050-px-Death-Note-Lawliet-L-1512241.jpg";
        sha256 = "0zxlrqzlcrzlcrkwf3gg7kpgz6snd9kb5mlbndjq650qwdj4ircl";
       
    };
in
pkgs.stdenv.mkDerivation {
    name = "sddm-theme";

    src = pkgs.fetchFromGitHub {
        owner = "3ximus";
        repo = "aerial-sddm-theme";
        rev = "c8d2a8f50decd08cb30f2fe70205901014985c9e";
        sha256 = "0csyw1vz76f1glz832jwss433pjbhpjxnlfww4rsxkc827v8d644";
    };
    installPhase = ''
        mkdir -p $out
        cp -R ./* $out/
        cd $out/
        cp -r ${background} background.jpg
    '';
}
