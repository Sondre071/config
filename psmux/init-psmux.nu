def init-psmux [] {
    const source_dir = path self
    | path dirname
    
    let link_dir = $env.userprofile
    
    [
        '.psmux.conf'
    ]
    | each {|file|
        let source_path = $source_dir | path join $file
        let link_path = $link_dir | path join $file

        create-hardlink $source_path $link_path
    }
}