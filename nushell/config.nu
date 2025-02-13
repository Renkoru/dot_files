# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
use '/home/mrurenko/.config/broot/launcher/nushell/br' *

$env.EDITOR = 'nvim'
$env.config.show_banner = false


def show_my_banner [] {
  let isterm = (is-terminal --stdin)
  if $isterm {
    let quote = (misfortune -s -L 3)
    print (artprint --random -t $quote)
  }
}

show_my_banner

$env.PATH = ($env.PATH | split row (char esep) | append "/home/mrurenko/go/bin")

$env.PATH = ($env.PATH | split row (char esep) | append "/opt/asdf-vm/bin")
let shims_dir = (
  if ( $env | get --ignore-errors ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)
$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

# https://github.com/nushell/nushell/issues/5597
# https://github.com/nushell/nushell/issues/5552
let abbreviations = {
    # "cd..": 'cd ..'
    # sau: 'sudo apt update; sudo apt upgrade'
    # bu: 'brew update; brew upgrade'

    lsa: 'eza -la --icons=auto'
    pupd: 'sudo pacman -Suy'
    yupd: 'yay -Suya'


    # Docker aliases
    dc: 'docker compose'
    dcu: 'docker compose up -d'
    dcs: 'docker compose stop'
    dcd: 'docker compose down'
    dps: 'docker compose ps'
    dlog: 'docker compose log'
}

$env.config = {
    keybindings: [
      {
        name: abbr_menu
        modifier: none
        keycode: enter
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { send: menu name: abbr_menu }
            { send: enter }
        ]
      }
      {
        name: abbr_menu
        modifier: none
        keycode: space
        mode: [emacs, vi_normal, vi_insert]
        event: [
            { send: menu name: abbr_menu }
            { edit: insertchar value: ' '}
        ]
      }
      {
         name: fuzzy_history
         modifier: control
         keycode: char_r
         mode: [emacs, vi_normal, vi_insert]
         event: [{
           send: ExecuteHostCommand
           cmd: "commandline edit --insert (
             history
               | get command
               | reverse
               | uniq
               | str join (char -i 0)
               | fzf
                  --preview '{}'
                  --preview-window 'right:30%'
                  --scheme history
                  --read0
                  --layout reverse
                  --height 40%
                  --query (commandline)
                | decode utf-8
                | str trim
             )"
         }]
      }
    ]

    menus: [
        {
            name: abbr_menu
            only_buffer_difference: false
            marker: none
            type: {
                layout: columnar
                columns: 1
                col_width: 20
                col_padding: 2
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
            source: { |buffer, position|
                let match = $abbreviations | columns | where $it == $buffer
                if ($match | is-empty) {
                    { value: $buffer }
                } else {
                    { value: ($abbreviations | get $match.0) }
                }
            }
        }
    ]
}


def suspendme [] {
    ~/dot_files/scripts/lock.sh
    systemctl suspend
}


# end of file additions
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu
source ~/.cache/carapace/init.nu
