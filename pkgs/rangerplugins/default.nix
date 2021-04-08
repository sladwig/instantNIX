{ lib
, stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation {

  pname = "rangerplugins";
  version = "unstable";

  srcs = [ 
    (fetchFromGitHub {
      # branch: main
      owner = "alexanderjeurissen";
      repo = "ranger_devicons";
      rev = "e02b6a3203411b76616a0e4328245bf8b47c5dcc";
      sha256 = "6V1jbPrUWdE6XBFKEUXoagTkPc3xuHUnCWJdFsc1YKU=";
      name = "ranger_devicons";
    })
    (fetchFromGitHub {
      owner = "laggardkernel";
      repo = "ranger-fzf-marks";
      rev = "79106fd6d9b98966e2683a52d35c25858ecb084a";
      sha256 = "0cz44lvbmn7jgw3p8slvkhmgfsnzcwky25j67ayp6igkv62wg79z";
      name = "ranger-fzf-marks";
    })
  ];

  sourceRoot = ".";
 
  installPhase = ''
    cleanPlugin () {
      mv $1/*.py .
      rm -rf "$1"
      mkdir "$1"
      mv *.py "$1"
    }
    cleanPlugin ranger-fzf-marks
    cleanPlugin ranger_devicons
    mkdir -p $out/share/rangerplugins
    touch $out/share/rangerplugins/__init__.py
    mv * $out/share/rangerplugins
    mv $out/share/rangerplugins/ranger_devicons/* $out/share/rangerplugins
  '';

  meta = with lib; {
    description = "instantOS rangerplugins";
    license = licenses.mit;
    homepage = "https://github.com/paperbenni/dotfiles";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
