def init-wezterm [] {
    init-wezterm-files
    init-wezterm-user-files
    init-wezterm-scripts
}

def init-wezterm-files [] {
    const source_dir = path self
    | path dirname

    let data_dir = $env.userprofile
    | path join '.config' 'wezterm'

    [
        'background.lua'
        'color_theme.lua'
        'favorite_paths.lua'
        'keybindings.lua'
        'scripts.lua'
        'wezterm.lua'
    ]
    | each {|file|
        let source_path = $source_dir
        | path join $file
        
        let link_path = $data_dir
        | path join $file

        create-hardlink $source_path $link_path
    }
}

def init-wezterm-user-files [] {
    const source_dir = path self
    | path dirname

    let data_dir = $env.userprofile
    | path join '.config' 'terminal'

    const files_to_create = [
    { 'name': 'background.json', 'value': '{"image": "", "brightness": 0.1, "saturation": 0.9}' },
    { 'name': 'favorite_paths', 'value': '' } ]

    $files_to_create | each {|file|
        let path = $data_dir | path join $file.name

        create-file $path $file.value
    }
}

def init-wezterm-scripts [] {
    const source_dir = path self
    | path dirname
    | path join 'scripts'

    let link_dir = $env.userprofile
    | path join '.config' 'terminal' 'scripts' 'Terminal'

    if not ($link_dir | path exists) {
        mkdir $link_dir
    }

    [
        'favorite_current_directory.nu'
        'unfavorite_current_directory.nu'
    ]
    | each {|file|
        let source_path = $source_dir | path join $file
        let link_path = $link_dir | path join $file

        create-hardlink $source_path $link_path
    }
}
