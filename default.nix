let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixpkgs_download = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "61deecdc34fc609d0f805b434101f3c8ae3b807a";
    sha256 = "147xyn8brvkfgz1z3jbk13w00h6camnf6z0bz0r21g9pn1vv7sb0";
  };
  nixpkgs = import nixpkgs_download {};
  pypkgs = nixpkgs.python36Packages;
  texlive = nixpkgs.pkgs.texlive;
  # latex = (texlive.combine { inherit (texlive) scheme-medium collection-latexextra collection-fontsrecommended; });
  latex = (texlive.combine { inherit (texlive) scheme-medium; });
in
  nixpkgs.stdenv.mkDerivation rec {
     name = "swc-jhu";
     env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
     buildInputs = [
       pypkgs.pip
       pypkgs.python
       pypkgs.numpy
       pypkgs.scipy
       nixpkgs.pkgs.git
       pypkgs.matplotlib
       pypkgs.tkinter
       pypkgs.pandas
       pypkgs.jupyter
       pypkgs.ipywidgets
       nixpkgs.pandoc
       nixpkgs.jekyll
       latex
     ];
     src=./.;
     doCheck=false;
     catchConflicts=false;
     postShellHook = ''
       SOURCE_DATE_EPOCH=$(date +%s)
       export PYTHONUSERBASE=$PWD/.local
       export USER_SITE=`python -c "import site; print(site.USER_SITE)"`
       export PYTHONPATH=$PYTHONPATH:$USER_SITE
       export PATH=$PATH:$PYTHONUSERBASE/bin

       ## To build a python package from pypi use
       # pip install --user package_name
       jupyter nbextension install --py widgetsnbextension --user
       jupyter nbextension enable widgetsnbextension --user --py
     '';
  }
