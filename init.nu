const project_dir = path self | path dirname

def main [] {
    let configs = [
        {
            name: autohotkey
            target_dir: (
                [
                    $env.USERPROFILE
                    'AppData'
                    'Roaming'
                    'Microsoft'
                    'Windows'
                    'Start Menu'
                    'Programs'
                    'Startup'
                ]
                | path join
            )
        }
        {
            name: intellij
            target_dir: $env.USERPROFILE
        }
        {
            name: nushell
            target_dir: (
                $env.USERPROFILE
                | path join '.config' 'nushell'
            )
        }
        {
            name: nvim
            target_dir: (
                $env.USERPROFILE
                | path join '.config' 'nvim'
            )
        }
        {
            name: psmux
            target_dir: $env.USERPROFILE
        }
        {
            name: terminal
            target_dir: (
                $env.USERPROFILE
                | path join '.config' 'terminal'
            )
        }
        {
            name: wezterm
            target_dir: (
                $env.USERPROFILE
                | path join '.config' 'wezterm'
            )
        }
        {
            name: zed
            target_dir: (
                $env.USERPROFILE
                | path join 'AppData' 'Roaming' 'Zed'
            )
        }
    ]

    $configs
    | each {|con|
        print $"(ansi yellow_bold)--- Inititalizing: (ansi white)($con.name) (ansi yellow)---(ansi reset)"

        let root_dir = $project_dir | path join $con.name
        let target_dir = $con.target_dir

        ls $"($root_dir)/**/*"
        | where type == file
        | each {|file|
            let source_path = $file.name
            let relative_path = $source_path | path relative-to $root_dir
            let link_path = $target_dir | path join $relative_path

            let parent_dir = $link_path | path dirname

            if not ($parent_dir | path exists) {
                mkdir $parent_dir
            }

            if not ($link_path | path exists --no-symlink) {
                ^mklink $link_path $source_path | ignore
                print $"(ansi green)Symlink created: (ansi white)($relative_path)(ansi reset)"
            } else {
                print $"(ansi yellow)Symlink already exists: (ansi white)($relative_path)(ansi reset)"
            }
        }

        let extra_init = $root_dir | path join '.extras' 'init.nu'

        if ($extra_init | path exists) {
            nu $extra_init
        }

        print ''
    }
    | ignore
}
