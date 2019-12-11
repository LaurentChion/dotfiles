#/bin/bash

if [ $SHELL = "/bin/zsh" ]
then
    echo "Zsh already define as default"
else
    echo "Setting up zsh as default"
    chsh -s /usr/bin/zsh

    # Getting antibody (zsh package manager)
    echo "Installing zsh packages"
    curl -sfL git.io/antibody | sh -s - -b .
fi