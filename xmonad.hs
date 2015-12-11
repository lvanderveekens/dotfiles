import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Graphics.X11.ExtraTypes.XF86
 
main = xmonad =<< myBar myConfig

myBar = xmobar

myConfig = defaultConfig { terminal = "xterm" 
                         , modMask = mod4Mask
                         , startupHook = setWMName "LG3D" } -- LG3D for java to recognize as a valid WM  
           `additionalKeys` myKeys

myKeys = [((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 2%+"), -- volume up 
          ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 2%-"), -- volume down 
          ((0, xF86XK_AudioMute), spawn "amixer set Master toggle"),     -- toggle volume 
          ((mod4Mask, xK_l), spawn "xscreensaver-command -lock")]        -- lock the screen       

