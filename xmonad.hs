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
import XMonad.Config.Mate
import Data.Char (toUpper)
import Control.Monad (liftM2)
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Actions.SwapWorkspaces
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.Place
import XMonad.Hooks.ServerMode
import XMonad.Hooks.UrgencyHook
-- import XMonad.Hooks.ManageHelpers (isDialog) -- Could be useful
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.ThreeColumns
import XMonad.Layout.OneBig
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Ungrab
import XMonad.StackSet as W
-- import System.IO

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

main :: IO ()
main = do
    dbus <- D.connectSession
    getWellKnownName dbus
    xmonad $ withUrgencyHookC BorderUrgencyHook { urgencyBorderColor = "#ff0000" } urgencyConfig { suppressWhen = Never } $ mateConfig
         {XMonad.workspaces = Main.workspaces
         , XMonad.focusFollowsMouse = Main.focusFollowsMouse
         , XMonad.clickJustFocuses= Main.clickJustFocuses
         , manageHook = myManageHook
         <+> manageHook mateConfig
         <+> namedScratchpadManageHook scratchpads
         -- ,startupHook = nspTrackStartup scratchpads
         , handleEventHook = serverModeEventHookCmd
         <+> serverModeEventHook
         <+>serverModeEventHookF "XMONAD_SPAWN" spawn
         , layoutHook = myLayout
         , logHook = do
            dynamicLogWithPP (prettyPrinter dbus)
            logHook mateConfig
         , modMask = mod4Mask
         , borderWidth = 3
         , focusedBorderColor = "#FFBB00"
         -- , focusedBorderColor = "#ffa71a"
         , normalBorderColor = "#000000"
         -- , normalBorderColor = "#5f676A"
         , terminal = "kitty"
         }
         `additionalKeys` myKeys

workspaces :: [WorkspaceId]
-- workspaces = map show [1 .. 9 :: Int] -- Default
-- workspaces = ["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "10"]
workspaces = map show $ concat [[1 .. 9 :: Int ], [0 :: Int]]

-- | Whether focus follows the mouse pointer.
focusFollowsMouse :: Bool
focusFollowsMouse = False

-- | Whether a mouse click select the focus or is just passed to the window
clickJustFocuses :: Bool
clickJustFocuses = False

myKeys:: [((KeyMask, KeySym), X())]
myKeys = [((mod4Mask .|. shiftMask, xK_q), spawn "mate-session-save --shutdown-dialog")
         , ((mod4Mask , xK_q), spawn "mate-session-save --logout-dialog")
         -- restart XMonad in place
         , ((mod4Mask  , xK_r), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
         , ((mod4Mask , xK_BackSpace), kill)
         , ((mod4Mask , xK_d), unGrab >> Main.matePanel "MAIN_MENU")
         -- , ((mod4Mask , xK_d), spawn "xdotool mousemove 12 12 sleep 0.2 click --clearmodifiers 1 mousemove restore") --to move the pointer back
         , ((0 , 0x1008ff81), spawn "~/scripts/toggle_evdev_wheel_em.sh")
         , ((mod4Mask , xK_g), goToSelected (def GSConfig))
         -- Ignore the scratchpad workspace while toggling:
         , ((mod4Mask , xK_Tab), toggleWS' ["NSP"])
         , ((mod4Mask , xK_grave), namedScratchpadAction scratchpads "barrier")
         , ((mod4Mask , xK_minus), namedScratchpadAction scratchpads "tabsoutliner")
         , ((mod4Mask , xK_Print), spawn "mate-screenshot --interactive")
         -- Move focus to the next window
         , ((mod4Mask , xK_Down), windows W.focusDown)
         -- Move focus to the previous window
         , ((mod4Mask, xK_Up), windows W.focusUp)
         -- Swap the focused window with the next window
         , ((mod4Mask .|. shiftMask, xK_Down), windows W.swapDown)
         -- Swap the focused window with the previous window
         , ((mod4Mask .|. shiftMask, xK_Up), windows W.swapUp)
         -- resizing the master/slave ratio
         , ((mod4Mask , xK_Left), sendMessage Shrink) -- %! Shrink the master area
         , ((mod4Mask , xK_Right), sendMessage Expand) -- %! Expand the master area
         , ((mod4Mask , xK_0), windows $ W.greedyView "0")
         , ((mod4Mask .|. shiftMask, xK_0), windows $ W.shift "0")
         ] ++
         -------------------------------------------------------------------
         -- alt+[1 .. ], Swap with workspace N and follow
         -- meta+ctrl+[1 .. ], Move client to workspace N and follow
         -- ctrl+F[1 .. ], Switch to workspace N
         -- ctrl+shift+F[1 .. ], View to workspace N
         -- meta+shift+F[1 .. ], Move client to workspace N
         -- alt+shift+F[1 .. ], Swap with workspace N
         [ ((m, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces mateConfig) $ concat [[xK_1 .. xK_9], [xK_0]]
         , (f, m) <- [(swapWithCurrent , mod1Mask)
                        , (liftM2 (.) W.greedyView W.shift, mod4Mask .|. controlMask)
                        -- , (W.greedyView , controlMask)
                        -- , (W.view , controlMask .|. shiftMask)
                        -- , (W.shift , mod4Mask .|. shiftMask)
                        -- , (silentSwapWithCurrent , mod1Mask .|. shiftMask)
                        ]
         ]
         -- ++
         -------------------------------------------------------------------
         -- Multiple Monitor bindings
         -- ctrl+meta+F[1 .. ], Switch to screen N
         -- ctrl+meta+shift+F[1 .. ], Move client to screen N
         -- alt+meta+F[1 .. ], Swap with screen N and follow
         -- alt+meta+shift+F[1 .. ], Swap with screen N
         -- [ ((m, k), screenWorkspace (S i) >>= flip whenJust (windows . f))
         -- | (i, k) <- zip [0 .. ] workspaceKeys
         -- , (f, m) <- [ (W.view               , controlMask .|. mod4Mask)
         --                , (W.shift              , controlMask .|. mod4Mask .|. shiftMask)
         --                , (swapWithCurrent      , mod1Mask .|. mod4Mask)
         --                , (silentSwapWithCurrent, mod1Mask .|. mod4Mask .|. shiftMask)
         --                ]
         -- ]
         ++
         -------------------------------------------------------------------
         -- meta+[c,v], Switch to workspace to the left or right
         -- alt+[c,v], Move window to left or right and follow
         -- alt+shift+[c,v], Move window to left or right
         -- alt+meta+[left,right], Swap with workspace to left or right and follow
         -- alt+meta+shift+[left,right], Swap with workspace to left or right
         [ ((m, xK_c ), c)
         | (c, m) <- [ (prevWS , mod4Mask)
                        , (shiftToPrev >> prevWS , mod1Mask)
                        , (shiftToPrev , mod1Mask .|. shiftMask)
                        -- , (swapTo Prev          , mod1Mask .|. mod4Mask)
                        -- , (swapTo Prev >> nextWS, mod1Mask .|. mod4Mask .|. shiftMask)
                        ]
         ]
         ++
         [ ((m, xK_v), c)
         | (c, m) <- [ (nextWS , mod4Mask)
                        , (shiftToNext >> nextWS, mod1Mask)
                        , (shiftToNext       , mod1Mask .|. shiftMask)
         --                , (swapTo Next          , mod1Mask .|. mod4Mask)
         --                , (swapTo Next >> prevWS, mod1Mask .|. mod4Mask .|. shiftMask)
                        ]
         ]

-- Opening MATE Menu without marco.
mateRun :: X ()
mateRun = matePanel "RUN_DIALOG"

matePanel:: String -> X ()
matePanel action = withDisplay $ \dpy -> do
    let panel = "_MATE_PANEL_ACTION"
    rw <- asks theRoot
    mate_panel <- getAtom panel
-- https://github.com/mate-desktop/marco/blob/ad411725cc733fbcba106d53356e0035573e6cb2/src/core/keybindings.c#L2914
    panel_action   <- getAtom (panel ++ "_" ++ map toUpper action)

    io $ allocaXEvent $ \e -> do
        setEventType e clientMessage
        setClientMessageEvent e rw mate_panel 32 panel_action 0
        sendEvent dpy rw False structureNotifyMask e
        sync dpy False

-- ManageHook are rules to manage different windows
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "mate-panel" --> doIgnore
    , className =? "Mate-control-center" --> doFloat
    , className =? "Gimp-2.10" --> doFloat
    , className =? "Steam" --> doFloat
    , title =? "Event Tester" --> doFloatPlace
    , title =? "Tabs Outliner" --> do
      _ <- doFloat
      doShift "tabsoutliner"
    , title =? "Tabs Outliner" --> doShift "tabsoutliner"
    , stringProperty "WM_WINDOW_ROLE" =? "pop-up" --> doFloatPlace
    , stringProperty "_NET_WM_STATE" =? "_NET_WM_STATE_STICKY" --> doIgnore
    , stringProperty "_NET_WM_WINDOW_TYPE" =? "_NET_WM_WINDOW_TYPE_DIALOG" --> doFloatPlace
    -- , isInProperty "_NET_WM_STATE" "_NET_WM_STATE_STICKY" --> doIgnore
    -- , isDialog --> doFloat
    , placeHook myPlaceHook
    ]
    <+> manageDocks -- make sure to include myManageHook definition from above

myPlaceHook :: Placement
myPlaceHook = inBounds $ fixed (0.5, 0.5)

doFloatPlace :: ManageHook
doFloatPlace = placeHook myPlaceHook <+> doFloat

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
prettyPrinter dbus = def
    { ppOutput   = dbusOutput dbus
    , ppTitle    = pangoColor "grey" . pangoSanitize
    -- , ppTitle    = const "" -- don't write anything
    -- , ppCurrent  = pangoColor "green" . wrap "[" "]" . pangoSanitize
    , ppCurrent  = pangoColor "white" . pangoSanitize . zeroToTen -- wrap "[" "]" . pangoSanitize
    , ppVisible  = pangoColor "yellow" . wrap "(" ")" . pangoSanitize . zeroToTen
    -- , ppHidden   = const ""
    , ppHidden   = pangoColor "grey" . pangoSanitize . zeroToTen . noScratchpad
    , ppUrgent   = pangoColor "red" . pangoSanitize . zeroToTen
    , ppLayout   = pangoColor "#C450C4" . filterNumbers
    , ppSep      = pangoColor "grey" " ⋮ "
    , ppWsSep    = "  "
    }

-- clickable' :: ScreenId -> VirtualWorkspace -> String
-- clickable' s w = xmobarAction ("xmonadctl view\\\"" ++ marshall s w ++ "\\\"") "1" w

getWellKnownName :: D.Client -> IO ()
getWellKnownName dbus = do
  _ <- D.requestName dbus (D.busName_ "org.xmonad.Log")
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
filterNumbers :: String -> String
filterNumbers = Prelude.filter (`notElem` ['0'..'9']++['.',' '])
-- pangoFilterNumbers = Prelude.filter (`elem` ['A'..'z'])

-- scratchPads
scratchpads :: [NamedScratchpad]
scratchpads = [
-- Find tabs outliner by title (don't run it), use default floating window placement
    NS "tabsoutliner"
       ""
       (title =? "Tabs Outliner")
       defaultFloating,
    NS "barrier"
       ""
       (className =? "Barrier")
       doFloatPlace
       -- (customFloating $ W.RationalRect (1/4) (1/4) 1 1)

    -- NS "term" "urxvtc -name scratchpad" (resource =? "scratchpad")
        -- (customFloating $ W.RationalRect (3/5) (4/6) (1/5) (1/6)),

    -- NS "pavucontrol" "pavucontrol" (className =? "Pavucontrol")
        -- (customFloating $ W.RationalRect (1/4) (1/4) (2/4) (2/4))
  ]

-- Function to hide NSP from DynamicLog
noScratchpad :: String -> String
noScratchpad ws = if ws == "NSP" then "" else ws

zeroToTen :: String -> String
zeroToTen ws = if ws == "0" then "10" else ws
