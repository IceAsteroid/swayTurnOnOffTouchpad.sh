# swayTurnOnOffTouchpad.sh
Turn on/off touchpad by the specified keybinding in Sway

# Explanation
Ever tired of disruption from touchpad when you're in a laptop doing some text heavy tasks.

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
