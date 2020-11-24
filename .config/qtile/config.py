from typing import List  # noqa: F401
import os
import subprocess

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile import hook

mod = "mod4"
terminal = "st"
launcher = "rofi -show drun -matching fuzzy"
window_switcher = "rofi -show window -matching fuzzy"

keys = [
    Key([mod], "k", lazy.layout.up(), desc="Move focus down"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus up"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus right"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_down(), desc="Move window right"),
    Key(
        [mod],
        "Tab",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    Key([mod, "shift"], "Tab", lazy.layout.rotate(), desc="Swap panes of split stack"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="fullscreen"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "x", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod, "shift"], "p", lazy.spawncmd(), desc="Run a command"),
    Key([mod], "p", lazy.spawn(launcher), desc="Open application launcher"),
    Key([mod], "w", lazy.spawn(window_switcher), desc="Open window switcher"),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.MonadTall(),
    layout.MonadWide(),
    layout.Max(),
    layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Jetbrains Mono Nerd Font",
    fontsize=12,
    padding=3,
    background="#1d2021",
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(disable_drag=True, hide_unused=True),
                widget.Prompt(),
                widget.WindowName(foreground="#cc241d"),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format="%H:%M:%S | %a %d.%m.%y | "),
                widget.Battery(
                    charge_char="+",
                    discharge_char="-",
                    update_interval=30,
                    format="{char} {percent:2.0%} {hour}:{min} | ",
                ),
                widget.Memory(format="{MemUsed}M/{MemTotal}M | "),
                widget.CPU(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        {"wmclass": "confirm"},
        {"wmclass": "dialog"},
        {"wmclass": "download"},
        {"wmclass": "error"},
        {"wmclass": "file_progress"},
        {"wmclass": "notification"},
        {"wmclass": "splash"},
        {"wmclass": "toolbar"},
        {"wmclass": "confirmreset"},  # gitk
        {"wmclass": "makebranch"},  # gitk
        {"wmclass": "maketag"},  # gitk
        {"wname": "branchdialog"},  # gitk
        {"wname": "pinentry"},  # GPG key password entry
        {"wmclass": "ssh-askpass"},  # ssh-askpass
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    os.system("flameshot &")
    os.system("dunst &")
    os.system("xbanish &")
    os.system("redshift &")
    os.system(
        "batsignal -w 20 -c 10 -f 100 -W 'BATTERY LOW' -C 'BATTERY CRITICAL' -F 'BATTERY FULL' -a 'battery' -b"
    )
    os.system("sxhkd &")
    os.system("thunar --daemon &")
    os.system("picom -C --config $HOME/.config/picom/picom.conf -b")
    os.system("feh --bg-scale $HOME/Pictures/wallpapers/gruvbox/garbage_math.png")
