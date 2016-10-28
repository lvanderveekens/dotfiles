import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.SimpleDecoration
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ICCCMFocus
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WorkspaceNames
import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Workspace
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.NoBorders
import System.IO
import Graphics.X11.ExtraTypes.XF86
import Data.Monoid 
import Data.List
import Data.List.Split

-- Notes:
-- the setVMName option causes firefox to fail on a resize
-- , startupHook = setWMName "LG3D" 
-- fixed it using _JAVA_AWT_WM_NONREPARENTING=1 in ~/.profile

-- Main config
main = do
    h <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook      = manageHook defaultConfig <+> myManageHook <+> manageDocks 

        -- TODO: startupHook to launch programs nm-applet & davmail
        --
        , layoutHook      = myLayoutHook 
        , handleEventHook = mconcat [ docksEventHook -- fix for xmobar to stop hiding behind windows
                                    , handleEventHook defaultConfig ]
        , logHook         = myLogHook h
        , modMask         = mod4Mask     
        , terminal        = "xfce4-terminal"
        , borderWidth     = 2
        , workspaces      = ["Web","Code", "Mail", "4", "5", "6", "7", "8", "9"] 
        } `additionalKeys` myKeys
            
-- Key configuration
myKeys = 
    [ ((mod4Mask .|. shiftMask,     xK_l), spawn "xscreensaver-command -lock") -- lock the screen 
    , ((0,       xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")      -- volume up
    , ((0,       xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")      -- volume down
    , ((0,              xF86XK_AudioMute), spawn "amixer set Master toggle")   -- mute
    , ((controlMask,            xK_Print), spawn "sleep 0.2; scrot -s")        -- screenshot
    , ((0 ,                     xK_Print), spawn "scrot")                      -- screenshot
    , ((0,                        xK_F12), spawn "~/Code/dotfiles/paste.sh")   -- paste the credentials for the NCC
    , ((mod4Mask .|. shiftMask,     xK_r), renameWorkspace defaultXPConfig)    -- rename the current workspace
    , ((mod4Mask .|. shiftMask,  xK_Left), swapTo Prev)                        -- move the current workspace to the previous slot
    , ((mod4Mask .|. shiftMask, xK_Right), swapTo Next)                        -- move the current workspace to the next slot
    , ((mod4Mask,               xK_Right), nextWS)                             -- switch to the next workspace
    , ((mod4Mask,                xK_Left), prevWS)                             -- switch to the previous workspace
    ]

-- Manage hook
myManageHook = composeAll . concat $
        [ [ className =? c --> doFloat | c <- classFloats]
        , [ title     =? t --> doFloat | t <- titleFloats]
        , [ title     =? t --> doShift "8" | t <- nccTitles]
        ]    
    where classFloats    = ["Gimp"]
          nccTitles   = ["Netinium AMM+ v2.27", "Netinium® AMM+ Login"]
          titleFloats = ["Help"]

-- Log hook
-- NOTE: updatePointer messes up the dragging of windows 
myLogHook h = (dynamicLogWithPP =<< workspaceNamesPP (myXmobar h)) >> updatePointer (0.5,0.5) (0,0)

-- Layout hook
myLayoutHook = avoidStruts $ smartSpacing 4 $ layoutHook defaultConfig

-- Xmobar
myXmobar h = xmobarPP { ppOutput  = hPutStrLn h
                      , ppTitle   = xmobarColor "yellow" "" . pad -- . shorten 100
                      , ppOrder   = \(w:l:ts) -> [w,l] ++ ts
                      , ppSep     = ""
                      , ppWsSep   = ""
                      , ppCurrent = xmobarColor "white" "red" . pad 
                      , ppVisible = xmobarColor "red" "" . pad
                      , ppHidden  = xmobarColor "white" "" . pad
                      , ppLayout  = \lay -> xmobarColor "black" "yellow" . pad  $ last $ splitOn "SmartSpacing 4 " lay
                      , ppHiddenNoWindows = xmobarColor "darkgrey" "" . pad
                      }
