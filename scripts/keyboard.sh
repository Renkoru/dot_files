#!/bin/bash

# Swap Left Control and Caps Lock
# Make Caps Lock a Control key
# Change keyboard layout. en, ru
setxkbmap -option
setxkbmap -option ctrl:swapcaps -option ctrl:nocaps -option grp:alt_shift_toggle -layout us,ru -rules evdev -model pc105

# Setting verbose level to 10
# locale is C
# Trying to load rules file ./rules/evdev...
# Trying to load rules file /usr/share/X11/xkb/rules/evdev...
# Success.
# Applied rules from evdev:
# rules:      evdev
# model:      pc105
# layout:     us,ru
# options:    grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps,grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps,grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps,grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps,grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps,grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps,grp:alt_shift_toggle,ctrl:nocaps,ctrl:swapcaps
# Trying to build keymap using the following components:
# keycodes:   evdev+aliases(qwerty)
# types:      complete
# compat:     complete
# symbols:    pc+us+ru:2+inet(evdev)+group(alt_shift_toggle)+ctrl(nocaps)+ctrl(swapcaps)
# geometry:   pc(pc105)
# xkb_keymap {
# 	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
# 	xkb_types     { include "complete"	};
# 	xkb_compat    { include "complete"	};
# 	xkb_symbols   { include "pc+us+ru:2+inet(evdev)+group(alt_shift_toggle)+ctrl(nocaps)+ctrl(swapcaps)"	};
# 	xkb_geometry  { include "pc(pc105)"	};
# };
