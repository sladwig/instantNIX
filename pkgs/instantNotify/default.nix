{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, instantMenu
, sqlite
}:
stdenv.mkDerivation {

  pname = "instantNotify";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "instantOS";
    repo = "instantNOTIFY";
    rev = "a6ae24280d276fe1ec50a32cdedf862172231ec6";
    sha256 = "sha256-1/akkSzcIE2QBlW0qGU6AkGBPV/qc6fpH5uS4wfJT/E=";
  };

  nativeBuildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ instantMenu sqlite ];

  postPatch = ''
    substituteInPlace install.sh \
      --replace "/usr" "$out" \
      --replace "sudo " ""
    patchShebangs *.sh
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    ./install.sh
    runHook postInstall
  '';

  postInstall = ''
    wrapProgram "$out/bin/instantnotifyctl" \
      --prefix PATH : ${lib.makeBinPath [ sqlite ]}
  '';

  meta = with lib; {
    description = "Notification system for instantOS";
    license = licenses.mit;
    homepage = "https://github.com/instantOS/instantNOTIFY";
    maintainers = [ "Scott Hamilton <sgn.hamilton+nixpkgs@protonmail.com>" ];
    platforms = platforms.linux;
  };
}
