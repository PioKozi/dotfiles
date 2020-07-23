--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import           Data.Monoid
import           System.Exit
import           XMonad

import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers

import           XMonad.Actions.WindowBringer

import           XMonad.Layout.BinarySpacePartition
import           XMonad.Layout.NoBorders
import           XMonad.Layout.ThreeColumns
import           XMonad.Layout.TwoPane

import qualified Data.Map                           as M
import qualified XMonad.StackSet                    as W

myTerminal      = "st"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2
myModMask       = mod4Mask
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myNormalBorderColor  = "#928374"
myFocusedBorderColor = "#cc241d"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_space     ), spawn "dmenu_run -n -p run: -i")

    -- close focused window
    , ((modm .|. shiftMask, xK_x     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_c ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_c ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap windows
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Resize master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_i ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_d), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. mod1Mask, xK_q     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Goto window or bring window to workspace via dmenu
    , ((modm .|. shiftMask, xK_g     ), gotoMenu)
    , ((modm .|. shiftMask, xK_b     ), bringMenu)
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    ]

------------------------------------------------------------------------
-- Layouts:
--
-- I hate how long this line is but whatever
myLayout = smartBorders tiled ||| smartBorders twopanes ||| smartBorders (Mirror tiled) ||| noBorders Full ||| smartBorders emptyBSP ||| smartBorders centermaster
  where
     tiled   = Tall nmaster delta ratio
     twopanes = TwoPane delta ratio
     centermaster = ThreeColMid nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 2/100

------------------------------------------------------------------------
-- Window rules:
myManageHook = composeAll
    [
    className =? "MPlayer"        --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook
myStartupHook = do
    spawnOnce "batsignal -w 20 -c 10 -f 100 -W 'BATTERY LOW' -C 'BATTERY CRITICAL' -F 'BATTERY FULL' -a 'battery' -b"
    spawnOnce "dunst &"
    spawnOnce "sxhkd &"
    spawnOnce "flameshot &"
    spawnOnce "xbanish &"
    spawnOnce "feh --no-fehbg --bg-fill $HOME/Pictures/wallpapers/gruvbox/garbage_math.png"

------------------------------------------------------------------------

-- myLayoutNames :: String -> String
-- myLayoutNames s = case s of "Tall"        -> "Tile"
--                             "TwoPane"     -> "OneSplit"
--                             "Mirror Tall" -> "BStack"
--                             "Full"        -> "Monocole"
--                             "BSP"         -> "BSP"
--                             "ThreeCol"    -> "ThreeCol"

main = do
    xmproc <- spawnPipe "xmobar /home/piotr/.config/xmobar/xmobar.config"
    xmonad $ docks defaults
        {
        layoutHook = avoidStruts $ layoutHook defaults,
        logHook = dynamicLogWithPP xmobarPP
            {
            ppOutput = \x -> hPutStrLn xmproc x,
            ppCurrent = xmobarColor "#cc241d" "" . wrap "<" ">",
            ppUrgent = xmobarColor "#d79921" "" . wrap "!" "!",
            ppExtras = [windowCount],
            ppTitle = xmobarColor "#cc241d" "" . shorten 60,
            -- ppLayout = myLayoutNames,
            ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
            }
        }

defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
