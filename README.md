# swayTurnOnOffTouchpad.sh
Turn on/off touchpad by the specified keybinding in Sway conf.

# Note: This script will probably not be updated as there is a more easy way existing
This script stops to be used by me, as I've found an easy way to turn on/off touchpad just by one-liner in sway conf.

For example:
~~~bindsym $mod+z input type:touchpad events toggle enabled disabled~~~

## Bounus: A workaround for touchpad malfunctioning after disabling & enabling or suspend

If you find that the touchpad suddenly needs to move cursor by two or more than one fingers, it's basically a bug upstream outside of sway and wlroots, it's a libinput problem.

You need to switch to another tty and then switch back to sway to let this issue disappear by Ctrl+Alt+F5 to tty5 for instance and back to the tty where sway is at, as a workaround,

posted by @treibholz

Relevant github issue post: https://github.com/swaywm/sway/issues/7090

# Explanation
Ever tired of disruptions from touchpad by your palm misplacing when you're in a laptop doing some text heavy tasks?

You can bind this script to a keybinding in Sway conf when you have a need to temporarily turn off touchpad events, and latter to use the same keybinding to turn on the touchpad back

# How to use
Help page
```
## Help Page ##
Usage:
  swayTurnOnOffTouchpad.sh [OPTION]
  -t Turn on or off events of selected touchpad device
  -c Configure which input device as touchpad
  -h Print help page
```
First, choose which input device to be used with option '-c'.
```
$: swayTurnOnOffTouchpad.sh -c
#14 Input device: Sleep Button
  Type: Keyboard
  Identifier: 0:3:Sleep_Button
  Product ID: 3
  Vendor ID: 0
  Active Keyboard Layout: English (US)
  Libinput Send Events: enabled

#15 Input device: Lid Switch
  Type: Switch
  Identifier: 0:5:Lid_Switch
  Product ID: 5
  Vendor ID: 0
  Libinput Send Events: enabled
  
# Choose input device as touchpad by ordinal
#(PROMPT)Enter number:
```
Specify the keybinding in Sway conf, for example:
```
# Just specify where the script is at.
bindsym $mod+z exec "$HOME/xxx/swayTurnOnOffTouchpad.sh -t &>/dev/null"
```
