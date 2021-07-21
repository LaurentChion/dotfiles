module Eww (
    startDaemon,
    closeAll
) where

import XMonad.Core

ewwPath :: String
ewwPath = "~/softwares/eww/target/release/eww" 

execEwwCommand :: String -> String -> ()
execEwwCommand command = spawm $ "exec " ++ ewwPath ++ " "++ command 
startDaemon = execEwwCommand "start" 

closeAll = spawn "exec ~/bin/eww close-all"