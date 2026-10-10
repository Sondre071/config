export def main [] {
    const scripts_path = '~/.config/terminal/scripts'
    | path expand

    let files = ls $"($scripts_path)/*/*" 
    | where ($it.name | str ends-with '.nu')

    let dirname_pad_length = $files
    | get name
    | path dirname
    | path basename
    | str length
    | math max

    let entries = $files
    | each {|file|
        let name = do {
            let prefix = $file.name
            | path dirname
            | path basename
            | fill --alignment l --character ' ' --width $dirname_pad_length

            let file_name = $file.name
            | path basename

            $"($prefix) / ($file_name)"
        }

        { name: $name path: $file.name }
    }

    let script_path = $entries
    | (
        tui split --sizes [40% 1fr]
        [
            (
                tui split --vertical --sizes [3 1fr] [
                    (tui search --focus --columns [name])
                    (tui table --columns [name])
                ]
            )
            (
                tui preview {|row| open $row.path}
            )
        ]
    )
    | tui run
    | get selected
    | get -o path

    if ($script_path | is-empty) {
        return
    }

    commandline edit $script_path --accept
}
