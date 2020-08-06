#/bin/bash

if [ $SHELL = "/bin/zsh" ]
then
    echo "Zsh already define as default"
else
    echo "Setting up zsh as default"
    chsh -s /usr/bin/zsh
fi