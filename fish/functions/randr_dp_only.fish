function randr_dp_only
    # xrandr --output DisplayPort-0 --same-as eDP 2560x1440+0+0
    xrandr --output eDP-1 --off --output DP-1 --auto
    # xrandr --output eDP1 --auto
    # xrandr --output DisplayPort-1 --auto
end
