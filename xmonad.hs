import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ICCCMFocus
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WorkspaceNames
import XMonad.Actions.CycleWS
import XMonad.Prompt
import XMonad.Prompt.Workspace
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.NoBorders
import System.IO
import Graphics.X11.ExtraTypes.XF86
import Data.Monoid 
import Data.List
import Data.List.Split

-- Main config
-- the setVMName option causes firefox to fail on a resize
-- , startupHook = setWMName "LG3D" 
-- fixed it using _JAVA_AWT_WM_NONREPARENTING=1 in ~/.profile
main = do
    h <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook      = manageHook defaultConfig <+> myManageHook <+> manageDocks 
        , layoutHook      = myLayoutHook 
        , handleEventHook = mconcat [ docksEventHook -- fix for xmobar to stop hiding behind windows
                                    , handleEventHook defaultConfig ]
        , logHook         = myLogHook h
        , modMask         = mod4Mask     
        , terminal        = "xfce4-terminal"
        , borderWidth     = 2
        , workspaces      = ["Web","Code", "Mail"] 
        } `additionalKeys` myKeys
            
-- Key configuration
myKeys = 
    [ ((mod4Mask .|. shiftMask,     xK_l), spawn "gnome-screensaver-command -l") -- lock the screen 
    , ((mod4Mask .|. shiftMask,     xK_r), renameWorkspace defaultXPConfig)      -- rename the current workspace
    , ((mod4Mask .|. shiftMask,  xK_Left), swapTo Prev)                         -- move the current workspace to the previous slot
    , ((mod4Mask .|. shiftMask, xK_Right), swapTo Next)                         -- move the current workspace to the next slot
    , ((mod4Mask,               xK_Right), nextWS)                              -- switch to the next workspace
    , ((mod4Mask,                xK_Left), prevWS)                              -- switch to the previous workspace
    , ((0,       xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")        -- increase the volume
    , ((0,       xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")        -- decrease the volume
    , ((0,              xF86XK_AudioMute), spawn "amixer set Master toggle")     -- mute
    , ((controlMask,            xK_Print), spawn "sleep 0.2; scrot -s")          -- screenshot
    , ((0 ,                     xK_Print), spawn "scrot")                        -- screenshot
    , ((0,                        xK_F12), spawn "~/Code/dotfiles/paste.sh")     -- paste the credentials for the NCC
    ]

myManageHook = composeAll . concat $
        [ [ className =? c --> doFloat | c <- myFloats]
        , [ title     =? t --> doFloat | t <- otherFloats]
        ]    
    where myFloats    = ["Gimp"]
          otherFloats = ["Netinium AMM+ v2.27"]

myLogHook h = (dynamicLogWithPP =<< workspaceNamesPP (myXmobar h)) >> updatePointer (0.5,0.5) (0,0)

-- Xmobar configuration
myXmobar h = xmobarPP { ppOutput  = hPutStrLn h
                      , ppTitle   = xmobarColor "white" "" . pad . shorten 100
                      , ppOrder   = \(w:l:ts) -> [w,l] ++ ts
                      , ppSep     = ""
                      , ppWsSep   = ""
                      , ppCurrent = xmobarColor "white" "red" . pad
                      , ppVisible = xmobarColor "red" "" . pad
                      , ppHidden  = xmobarColor "grey" "" . pad
                      , ppLayout  = \lay -> xmobarColor "black" "yellow" . pad $ last $ splitOn "SmartSpacing 4 " lay
                     --, ppHiddenNoWindows = xmobarColor "#000000" "" . pad
                      }

myLayoutHook = avoidStruts $ smartSpacing 4 $ layoutHook defaultConfig

