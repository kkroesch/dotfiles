{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [ 
    gum
    git
    gh
    kubectl
    yq-go
  ];
}
