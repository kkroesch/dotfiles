{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [ 
    gum
    git
    gh
    kubectl
    yq-go
  ];
  shellHook = ''
    gum style \
      --foreground 212 --border-foreground 212 --border double \
      --margin "1 2" --padding "2 4" \
      'Setup for Kubernetes Computing.

    This script enables you to manage Kubernetes resources.'
    
    export PS1="(NIX) > "
  '';
}
