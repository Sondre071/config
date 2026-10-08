export def main [] {
    const scripts_path = '~/.config/terminal/scripts'
    | path expand

    # ls the path and one level down
    let files = ls ...[ $scripts_path $"($scripts_path)/*/*" ]
    | where ($it.name | str ends-with '.nu') 

    let path = $files
    | rename --column { name: path }
    | insert name {|row|
        $row.path
        | path basename
    }
    | (tui split --sizes [40% 1fr]
        [
            (
                tui split --vertical --sizes [3 1fr] [
                    (tui search --focus --columns [name])
                    (tui table --columns [name size])
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

    if ($path | is-empty) {
        return
    }

    commandline edit $path --accept
}
