source './intellij/init-intellij.nu'
source './nushell/init-nushell.nu'
source './psmux/init-psmux.nu'
source './wezterm/init-wezterm.nu'
source './zed/init-zed.nu'

def main [] {
    init-intellij
    init-nushell
    init-psmux
    init-wezterm
    init-zed
}

def create-file [path: string, value?: string] {
    print $"(ansi yb)path: (ansi wb)($path)(ansi reset)"

    if ($path | path exists) {
        print $"(ansi y)file already exists(ansi reset)"
    }

    let approve = (input 'proceed? y/n: ') =~ '^(?i:y)$'

    if $approve {
        let parent_dir = $path | path dirname
        if not ($parent_dir | path exists) {
            mkdir $parent_dir
        }
        
        $value | save -f $path

        print $"(ansi y)created file: (ansi w)($path)(ansi reset)\n"
    } else {
        print $"(ansi y)did not file: (ansi w)($path)(ansi reset)\n"
    }
}

def create-hardlink [source_path: string, link_path: string] {
    print $"(ansi yb)path: (ansi wb)($link_path)(ansi reset)"

    if ($link_path | path exists) {
        print $"(ansi y)link already exists, skipping(ansi reset)\n"
        return
    }

    let approve = (input 'proceed? y/n: ') =~ '^(?i:y)$'

    if $approve {
        let parent_dir = $link_path | path dirname
        if not ($parent_dir | path exists) {
            mkdir $parent_dir
        }
        
        ^mklink /H $link_path $source_path
        print "\n"
    } else {
        print $"(ansi y)did not link: (ansi w)($link_path)(ansi reset)\n"
    }
}

