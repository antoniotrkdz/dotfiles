{-_______________________________________________/\\\__________________________
_____________________________/\\\________________\/\\\_________________________
_____/\\\____________________\/\\\________________\/\\\________________________
___/\\\\\\\\\\\__/\\/\\\\\\\__\/\\\\\\\\___________\/\\\___/\\\\\\\\\\\________
___\////\\\////__\/\\\/////\\\_\/\\\////\\\____/\\\\\\\\\__\///////\\\/________
_______\/\\\______\/\\\___\///__\/\\\\\\\\/____/\\\////\\\_______/\\\/_________
________\/\\\_/\\__\/\\\_________\/\\\///\\\___\/\\\__\/\\\_____/\\\/__________
_________\//\\\\\___\/\\\_________\/\\\_\///\\\_\//\\\\\\\/\\__/\\\\\\\\\\\____
___________\/////____\///__________\///____\///___\///////\//__\///////////____
_______________________________________________________________________________

═╗ ╦ ╔╦╗ ╔═╗ ╔╗╔ ╔═╗ ╔╦╗     ╦ ╦ ╔═╗
╔╩╦╝ ║║║ ║ ║ ║║║ ╠═╣  ║║     ╠═╣ ╚═╗
╩ ╚═ ╩ ╩ ╚═╝ ╝╚╝ ╩ ╩ ═╩╝  o  ╩ ╩ ╚═╝                                         -}

{-# LANGUAGE OverloadedStrings #-}

import XMonad
-- import XMonad.Config.Desktop
import XMonad.Config.Mate
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Actions.CycleWS
import XMonad.Util.NamedScratchpad
import XMonad.StackSet as W
import XMonad.Layout.ThreeColumns
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.OneBig
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import System.IO
import XMonad.Util.Ungrab

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

-- Opening MATE Menu without marco.
mateMenu :: X ()
mateMenu = withDisplay $ \dpy -> do
    rw <- asks theRoot
    mate_panel <- getAtom "_MATE_PANEL_ACTION"
    panel_menu   <- getAtom "_MATE_PANEL_ACTION_MAIN_MENU"

    io $ allocaXEvent $ \e -> do
        setEventType e clientMessage
        setClientMessageEvent e rw mate_panel 32 panel_menu 0
        sendEvent dpy rw False structureNotifyMask e
        sync dpy False

-- ManageHook are rules to manage different windows 
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "mate-panel" --> doIgnore
    , className =? "Gimp-2.10"      --> doFloat
    , title =? "Tabs Outliner" --> doFloat
    , stringProperty "WM_WINDOW_ROLE" =? "pop-up" --> doFloat
    -- , isInProperty "_NET_WM_STATE" "_NET_WM_STATE_STICKY" --> doIgnore
    -- , isDialog --> doFloat
    ]
    <+> manageDocks -- make sure to include myManageHook definition from above

main :: IO ()
main = do
    dbus <- D.connectSession
    getWellKnownName dbus
    -- xmonad $ desktopConfig
    xmonad $ mateConfig
         { manageHook = myManageHook
         <+> manageHook mateConfig
         <+> namedScratchpadManageHook scratchpads
         , layoutHook = myLayout
         , logHook = dynamicLogWithPP (prettyPrinter dbus)
         , modMask = mod4Mask
         , borderWidth = 3
         , focusedBorderColor = "#FFBB00"
         , normalBorderColor = "#5f676A"
         , terminal = "kitty"
         } `additionalKeys`
         [ ((mod4Mask .|. shiftMask, xK_s), spawn "mate-session-save --shutdown-dialog")
         , ((mod4Mask , xK_d), unGrab >> mateMenu)
         -- , ((mod4Mask , xK_d), spawn "xdotool mousemove 12 12 sleep 0.2 click --clearmodifiers 1 mousemove restore") --to move the pointer back
         , ((0 , 0x1008ff81), spawn "~/scripts/toggle_evdev_wheel_em.sh")
         , ((mod4Mask , xK_g), goToSelected defaultGSConfig)
         -- Ignore the scratchpad workspace while toggling:
         , ((mod4Mask , xK_Tab), toggleWS' ["NSP"])
         -- , ((mod4Mask , xK_grave), toggleWS' ["NSP"])
         , ((mod4Mask , xK_minus), namedScratchpadAction scratchpads "tabsoutliner")
         , ((mod4Mask , xK_Print), spawn "mate-screenshot --interactive")
         -- Move focus to the next window
         , ((mod4Mask , xK_Left), windows W.focusDown)
         -- Move focus to the previous window
         , ((mod4Mask, xK_Right), windows W.focusUp)
         -- Swap the focused window with the next window
         , ((mod4Mask .|. shiftMask, xK_Left), windows W.swapDown)
         -- Swap the focused window with the previous window
         , ((mod4Mask .|. shiftMask, xK_Right), windows W.swapUp)
         ]

-- Define Layout
myLayout =  avoidStruts $ tiled ||| Full ||| threeColMid ||| emptyBSP ||| onebig
    where tiled = Tall nmaster delta ratio
          threeColMid = ThreeColMid nmaster delta ratio
          onebig = OneBig width height
          nmaster = 1 -- default number of windows in master screen
          delta = 3/100 -- default percent of resizing panes
          ratio = 1/2 -- default proportion of screen occupied by master pane
          height = 3/4 -- height of the big window (portion of the screen)
          width = 3/4 -- width of the big window

-- Functions for the (MATE) Panel applet (DynamicLog)
prettyPrinter :: D.Client -> PP
prettyPrinter dbus = defaultPP
    { ppOutput   = dbusOutput dbus
    -- , ppTitle    = pangoSanitize
    , ppTitle    = const "" -- don't write anything
    -- , ppCurrent  = pangoColor "green" . wrap "[" "]" . pangoSanitize
    , ppCurrent  = pangoColor "white" . pangoSanitize -- wrap "[" "]" . pangoSanitize
    , ppVisible  = pangoColor "yellow" . wrap "(" ")" . pangoSanitize
    -- , ppHidden   = const ""
    , ppHidden   = pangoColor "grey" . pangoSanitize . noScratchpad
    , ppUrgent   = pangoColor "red"
    , ppLayout   = pangoColor "grey" . pangoFilterNumbers
    , ppSep      = pangoColor "grey" " : "
    }

getWellKnownName :: D.Client -> IO ()
getWellKnownName dbus = do
  D.requestName dbus (D.busName_ "org.xmonad.Log")
                [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  return ()

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal "/org/xmonad/Log" "org.xmonad.Log" "Update") {
            D.signalBody = [D.toVariant ("<b>" ++ (UTF8.decodeString str) ++ "</b>")]
        }
    D.emit dbus signal

-- Function to set color of Pretty Printer
pangoColor :: String -> String -> String
pangoColor fg = wrap left right
  where
    left  = "<span foreground=\"" ++ fg ++ "\">"
    right = "</span>"

-- Function to reduce size of Pretty Printer
pangoFormat :: String -> String
pangoFormat = wrap left right
  where
    left  = "<small>"
    right = "</small>"

-- Function to sanitize output of Pretty Printer
pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
  where
    sanitize '>'  xs = "&gt;" ++ xs
    sanitize '<'  xs = "&lt;" ++ xs
    sanitize '\"' xs = "&quot;" ++ xs
    sanitize '&'  xs = "&amp;" ++ xs
    sanitize x    xs = x:xs

-- Function to remove numbers from output of Pretty Printer
pangoFilterNumbers :: String -> String
pangoFilterNumbers = Prelude.filter (`notElem` ['0'..'9']++['.'])
-- pangoFilterNumbers = Prelude.filter (`elem` ['A'..'z'])

-- scratchPads
scratchpads :: [NamedScratchpad]
scratchpads = [
-- Find tabs outliner by title (don't run it), use default floating window placement
    NS "tabsoutliner"
       ""
       (title =? "Tabs Outliner")
       defaultFloating
       -- (customFloating $ W.RationalRect (2/6) (2/6) (2/6) (2/6))

    -- NS "term" "urxvtc -name scratchpad" (resource =? "scratchpad")
        -- (customFloating $ W.RationalRect (3/5) (4/6) (1/5) (1/6)),

    -- NS "pavucontrol" "pavucontrol" (className =? "Pavucontrol")
        -- (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4))
  ]

-- Function to hide NSP from DynamicLog
noScratchpad :: String -> String
noScratchpad ws = if ws == "NSP" then "" else ws
