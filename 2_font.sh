# /bin/bash

# Download font and store it
mkdir ~/.fonts
# curl -L -o ~/.fonts/Delugia.Nerd.Font.Complete.ttf https://github.com/adam7/delugia-code/releases/download/v1911.21/Delugia.Nerd.Font.Complete.ttf
# curl -L -o ~/.fonts/Symbols-2048-em\ Nerd\ Font\ Complete.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf

# install Jetbrains Mono font
curl -L -o ~/.fonts/JetBrainsMono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip -j ~/.fonts/JetBrainsMono.zip "fonts/*" -d ~/.fonts/
rm -f ~/.fonts/JetBrainsMono.zip

# echo "Font installed, remember to setup inside your CODE editor"
# echo "Font name: 'Delugia Nerd Font'"

echo "JetBrainsMono Font installed"
