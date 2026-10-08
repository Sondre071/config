use 'lib/move-menu.nu'
use 'lib/scripts-menu.nu'
use 'lib/snippets-menu.nu'

# config.nu
#
# Installed by:
# version = "0.114.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# Disables newline on each keypress

$env.config.shell_integration.osc133 = false

$env.config.buffer_editor = 'nvim'
$env.config.edit_mode = 'vi'
$env.config.table.mode = 'light'

$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_INDICATOR_VI_NORMAL = ': '
$env.PROMPT_INDICATOR_VI_INSERT = '> '
$env.PROMPT_MULTILINE_INDICATOR = ': '

$env.config.keybindings = [
    {
        name: 'scripts-menu'
        modifier: 'none'
        keycode: 'F1'
        mode: [vi_normal vi_insert]
        event: [
            {
                send: executehostcommand
                cmd: 'scripts-menu'
            }
        ]
    }
    {
        name: 'snippets-menu'
        modifier: 'none'
        keycode: 'F2'
        mode: [vi_normal vi_insert]
        event: [
            {
                send: executehostcommand
                cmd: 'snippets-menu'
            }
        ]
    }

    # Simply re-bind default help menu away from F1
    { 
        name: help_menu
        modifier: 'none'
        keycode: 'F5'
        mode: [vi_normal]
        event: [
            {
                send: menu
                name: help_menu
            }
        ]
    }
    
    # Simply re-bind default help menu away from F1
    { 
        name: move_menu
        modifier: 'none'
        keycode: 'F3'
        mode: [vi_normal vi_insert]
        event: [
            {
                send: executehostcommand
                cmd: 'move-menu'
            }
        ]
    }
]

def npm [...$args] {
    error make "Not implemented. Run PowerShell instead."
}

def npx [...$args] {
    error make "Not implemented. Run PowerShell instead."
}

def pnpm [...$args] {
    error make "Not implemented. Run PowerShell instead."
}

const NU_LIB_DIRS = [
  '~/Dev/NuModules/DokflytCLI'
]

use dokflyt-cli.nu df

