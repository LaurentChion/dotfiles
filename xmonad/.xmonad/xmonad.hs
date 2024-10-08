-- Fork from the xmonad configuration of Derek Taylor (DistroTube)
-- http://www.youtube.com/c/DistroTube
-- http://www.gitlab.com/dwt1/

------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
    -- Base
import XMonad
import XMonad.Config.Desktop
import Data.Monoid
import Data.Maybe (isJust)
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Utilities
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings, removeKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat)
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

    -- Actions
import XMonad.Actions.Minimize (minimizeWindow)
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen, shiftNextScreen, shiftPrevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
import XMonad.Actions.MouseResize
import qualified XMonad.Actions.ConstrainedResize as Sqr

    -- Layouts modifiers
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing (spacing)
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
import XMonad.Layout.IM (withIM, Property(Role))


    -- Prompts
import XMonad.Prompt (defaultXPConfig, XPConfig(..), XPPosition(Top), Direction1D(..))

import XMonad.Config.Azerty ( belgianKeys )

-- import Eww (startDaemon, closeAll)

------------------------------------------------------------------------
---CONFIG
------------------------------------------------------------------------
myFont          = "xft:Delugia Nerd Font:regular:pixelsize=12"
myModMask       = mod4Mask  -- Sets modkey to super/windows key
myTerminal      = "kitty"      -- Sets default terminal
myTextEditor    = "nano"     -- Sets default text editor
myBorderWidth   = 0         -- Sets border width for windows
windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


------------------------------------------------------------------------
---AUTOSTART
------------------------------------------------------------------------
myStartupHook = do
          --spawnOnce "emacs --daemon &" 
          spawnOnce "nitrogen --restore &"
          spawnOnce "picom &" -- or picom
          setWMName "LG3D" -- for java
          -- spawnOnce "exec /usr/bin/trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --transparent true --alpha 0 --tint 0x292d3e --height 19 &"
          spawnOnce "dunst"
          -- spawnOnce "~/softwares/eww/target/release/eww daemon"

------------------------------------------------------------------------
---GRID SELECT
------------------------------------------------------------------------

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x31,0x2e,0x39) -- lowest inactive bg
                  (0x31,0x2e,0x39) -- highest inactive bg
                  (0x61,0x57,0x72) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0xff,0xff,0xff) -- active fg

-- gridSelect menu layout
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 30
    , gs_cellwidth    = 200
    , gs_cellpadding  = 8
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def -- defaultGSConfig

------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
myKeys =
    -- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-<Escape>", io exitSuccess)                  -- Quits xmonad

    -- Lockscreen
        , ("M-S-l", spawn "slock")

    -- Windows
        , ("M-S-q", kill1)                           -- Kill the currently focused client
        , ("M-S-a", killAll)                         -- Kill all the windows on current workspace

    -- Floating windows
        , ("M-f", withFocused $ windows . W.sink)  -- Push floating window back to tile.
        , ("M-S-f", sinkAll)                  -- Push ALL floating windows back to tile.

        , ("M-S-g", goToSelected $ mygridConfig myColorizer)
        , ("M-S-b", bringSelected $ mygridConfig myColorizer)

    -- Windows navigation
        , ("M-m", windows W.focusMaster)             -- Move focus to the master window
        , ("M-n", windows W.focusDown)               -- Move focus to the next window
        , ("M-i", windows W.focusUp)                 -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window
        , ("M-S-n", windows W.swapDown)              -- Swap the focused window with the next window
        , ("M-S-i", windows W.swapUp)                -- Swap the focused window with the prev window
        , ("M-<Backspace>", promote)                 -- Moves focused window to master, all others maintain order
        , ("M1-S-<Tab>", rotSlavesDown)              -- Rotate all windows except master and keep focus in place
        , ("M1-C-<Tab>", rotAllDown)                 -- Rotate all the windows in the current stack
        , ("M-S-s", windows copyToAll)
        , ("M-C-s", killAllOtherCopies)

        , ("M-C-M1-<Up>", sendMessage Arrange)
        , ("M-C-M1-<Down>", sendMessage DeArrange)
        , ("M-<Up>", sendMessage (MoveUp 10))             --  Move focused window to up
        , ("M-<Down>", sendMessage (MoveDown 10))         --  Move focused window to down
        , ("M-<Right>", sendMessage (MoveRight 10))       --  Move focused window to right
        , ("M-<Left>", sendMessage (MoveLeft 10))         --  Move focused window to left
        , ("M-S-<Up>", sendMessage (IncreaseUp 10))       --  Increase size of focused window up
        , ("M-S-<Down>", sendMessage (IncreaseDown 10))   --  Increase size of focused window down
        , ("M-S-<Right>", sendMessage (IncreaseRight 10)) --  Increase size of focused window right
        , ("M-S-<Left>", sendMessage (IncreaseLeft 10))   --  Increase size of focused window left
        , ("M-C-<Up>", sendMessage (DecreaseUp 10))       --  Decrease size of focused window up
        , ("M-C-<Down>", sendMessage (DecreaseDown 10))   --  Decrease size of focused window down
        , ("M-C-<Right>", sendMessage (DecreaseRight 10)) --  Decrease size of focused window right
        , ("M-C-<Left>", sendMessage (DecreaseLeft 10))   --  Decrease size of focused window left

    -- Layouts
        , ("M-l", sendMessage NextLayout)                              -- Switch to next layout
        --, ("M-S-<Space>", sendMessage ToggleStruts)                          -- Toggles struts
        --, ("M-S-n", sendMessage $ Toggle NOBORDERS)                          -- Toggles noborder
        , ("M-t", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
        --, ("M-f", sendMessage (T.Toggle "float"))
        --, ("M-S-x", sendMessage $ Toggle REFLECTX)
        --, ("M-S-y", sendMessage $ Toggle REFLECTY)
        --, ("M-S-m", sendMessage $ Toggle MIRROR)
        --, ("M-<KP_Multiply>", sendMessage (IncMasterN 1))   -- Increase number of clients in the master pane
        --, ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))  -- Decrease number of clients in the master pane
        --, ("M-S-<KP_Multiply>", increaseLimit)              -- Increase number of windows that can be shown
        --, ("M-S-<KP_Divide>", decreaseLimit)                -- Decrease number of windows that can be shown

        -- , ("M-h", sendMessage Shrink)
        --, ("M-l", sendMessage Expand)
        --, ("M-C-j", sendMessage MirrorShrink)
        --, ("M-C-k", sendMessage MirrorExpand)
        --, ("M-S-;", sendMessage zoomReset)
        --, ("M-;", sendMessage ZoomFullToggle)

    -- Workspaces
        , ("M-.", nextScreen)                           -- Switch focus to next monitor
        , ("M-,", prevScreen)                           -- Switch focus to prev monitor
        , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next workspace
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to previous workspace

    -- Scratchpads
        --, ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal")
        --, ("M-C-c", namedScratchpadAction myScratchPads "cmus")

    -- Main Shortcuts
        , ("M-<Return>", spawn myTerminal)
        -- , ("M-<Return>", spawn ("__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia " ++ myTerminal))
        , ("M-S-<Return>", spawn "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia firefox")
        , ("M-<Space>", spawn "rofi -show drun -theme Arc-Dark")

    -- Multimedia Keys
        --, ("<XF86AudioPlay>", spawn "cmus toggle")
        --, ("<XF86AudioPrev>", spawn "cmus prev")
        --, ("<XF86AudioNext>", spawn "cmus next")
        , ("<XF86AudioMute>",   spawn "amixer set Master toggle")  -- Bug prevents it from toggling correctly in 12.04.
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        --, ("<XF86HomePage>", spawn "firefox")
        --, ("<XF86Search>", safeSpawn "firefox" ["https://www.google.com/"])
        , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 20")
        , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 20")
        -- , ("<XF86Mail>", runOrRaise "geary" (resource =? "thunderbird"))
        --, ("<XF86Calculator>", runOrRaise "gcalctool" (resource =? "gcalctool"))
        -- , ("<XF86Eject>", spawn "toggleeject")
        , ("<Print>", spawn "gnome-screenshot --area")

    -- EWW shortcuts
        -- ,("M-e", spawn "~/softwares/eww/target/release/eww open time_side")
        -- ,("M-S-e", spawn "~/softwares/eww/target/release/eww close-all")

        ] where nonNSP          = WSIs (return (\ws -> W.tag ws /= "nsp"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))

------------------------------------------------------------------------
---WORKSPACES
------------------------------------------------------------------------

xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . map xmobarEscape
               $ ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  where
        clickable l = [ "<action=xdotool key super+" ++ show n ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..9] l,
                      let n = i ]
--myManageHook :: Query (Data.Monoid.Endo WindowSet)
--myManageHook = composeAll
     --[
        --className =? "Firefox"     --> doShift "<action=xdotool key super+2>www</action>"
      -- , title =? "Vivaldi"         --> doShift "<action=xdotool key super+2>www</action>"
      -- , title =? "irssi"           --> doShift "<action=xdotool key super+6>chat</action>"
      -- , className =? "cmus"        --> doShift "<action=xdotool key super+7>media</action>"
      -- , className =? "vlc"         --> doShift "<action=xdotool key super+7>media</action>"
      --, className =? "Virtualbox"  --> doFloat
      -- , className =? "Gimp"        --> doFloat
      --, className =? "Gimp"        --> doShift "<action=xdotool key super+8>gfx</action>"
      --, (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     --] <+> namedScratchpadManageHook myScratchPads

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------

myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ --T.toggleLayouts monocle $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where
                myDefaultLayout = tall ||| grid -- ||| monocle --tall ||| grid ||| threeCol ||| threeRow ||| oneBig ||| noBorders monocle ||| space ||| floats

tall       = renamed [Replace "tall"]     $ limitWindows 12 $ spacing 6 $ ResizableTall 1 (3/100) (1/2) []
grid       = renamed [Replace "grid"]     $ limitWindows 12 $ spacing 6 $ mkToggle (single MIRROR) $ Grid (16/10)
--threeCol   = renamed [Replace "threeCol"] $ limitWindows 3  $ ThreeCol 1 (3/100) (1/2) 
--threeRow   = renamed [Replace "threeRow"] $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
--oneBig     = renamed [Replace "oneBig"]   $ limitWindows 6  $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
-- monocle    = renamed [Replace "monocle"]  $ Full-- $ limitWindows 20 $ Full
--space      = renamed [Replace "space"]    $ limitWindows 4  $ spacing 12 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
--floats     = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat

------------------------------------------------------------------------
---SCRATCHPAD
------------------------------------------------------------------------

myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                --, NS "cmus" spawnCmus findCmus manageCmus  
                ]

    where
    spawnTerm  = myTerminal ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCmus  = myTerminal ++  " -n cmus 'cmus'"
    findCmus   = resource =? "cmus"
    manageCmus = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

---------
-- Colors
---------
base03  = "#272822"
base02  = "#48483e"
base01  = "#555645"
base00  = "#76715e"
base0   = "#839496"
base1   = "#acada1"
base2   = "#f1ebeb"
base3   = "#cfd0c2"
yellow  = "#e7db75"
orange  = "#fba922"
red     = "#cc342b"
magenta = "#fa2772"
violet  = "#9358fe"
blue    = "#55bcce"
cyan    = "#66efd5"
green   = "#8fc029"

------------------------------------------------------------------------
---MAIN
------------------------------------------------------------------------
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.xmonad/xmobarrc"
    -- xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.xmonad/xmobarrc2"
    -- xmproc2 <- spawnPipe "xmobar -x 2 $HOME/.config/xmobar/xmobarrc1"

    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh $ desktopConfig
        { manageHook = ( isFullscreen --> doFullFloat )
            -- <+> myManageHook
            <+> manageHook desktopConfig <+> manageDocks
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc0 -- >> hPutStrLn xmproc1 x  >> hPutStrLn xmproc2 x
                        , ppCurrent = xmobarColor green "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor green ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor blue "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor base00 ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor base2 "" . shorten 80     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> | </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor magenta "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = base03
        , focusedBorderColor = base2
        , keys = \c -> belgianKeys c <+> keys desktopConfig c
        } `additionalKeysP`         myKeys
