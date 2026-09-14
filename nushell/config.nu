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

const NU_LIB_DIRS = [
  '~/Dev/NuModules/DokflytCLI'
]

use dokflyt-cli.nu [ df df-local df-sql ]

# Prevent using npm without aikido safe-chain
def npm [...args] {
    error make {
        msg: "Execution Blocked: npm is banned on this shell profile."
    }
}

def pnpm [...args] {
    error make {
        msg: "Execution Blocked: npm is banned on this shell profile."
    }
}

def npx [...args] {
    error make {
        msg: "Execution Blocked: npm is banned on this shell profile."
    }
}
