# env.nu
#
# Installed by:
# version = "0.101.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

zoxide init nushell | save -f ~/.zoxide.nu

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
$env.PI_ACP_ENABLE_EMBEDDED_CONTEXT = true
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# Add mise to PATH so it can be found during shell init
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local" "bin"))
let mise_path = $nu.default-config-dir | path join mise.nu
# temporarty fix mise config with new nushell changes of "uppercase"
^mise activate nu | str replace --all "upcase" "uppercase" | save $mise_path --force
