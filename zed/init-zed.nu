def init-zed [] {
    const source_dir = path self
    | path dirname
    
    let link_dir = $env.userprofile
    | path join 'AppData' 'Roaming' 'Zed' 
    
    [
        'keymap.json'
        'settings.json'
    ]
    | each {|file|
        let source_path = $source_dir | path join $file
        let link_path = $link_dir | path join $file

        create-hardlink $source_path $link_path
    }
}
