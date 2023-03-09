# swayTurnOnOffTouchpad.sh
Turn on/off touchpad by the specified keybinding in Sway

# Explanation
Ever tired of disruption from touchpad when you're in a laptop doing some text heavy tasks.

You can bind this script to a keybinding in Sway conf when you have a need to temporarily turn off touchpad events, and latter to use the same keybinding to turn on the touchpad back

# How to use
For example:
```
bindsym $mod+z exec "$HOME/Bin/swayTurnOnOffTouchpad.sh -t &>/dev/null"
```
