# /bin/bash

# Download font and store it
mkdir ~/.fonts
curl -L -o ~/.fonts/Delugia.Nerd.Font.Complete.ttf https://github.com/adam7/delugia-code/releases/download/v1911.21/Delugia.Nerd.Font.Complete.ttf
curl -L -o ~/.fonts/Symbols-2048-em\ Nerd\ Font\ Complete.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf

echo "Font installed, remember to setup inside your CODE editor"
echo "Font name: 'Delugia Nerd Font'" 