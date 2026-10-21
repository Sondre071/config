export def main [] {
    const favorite_paths_path = '~/.config/terminal/favorite_paths'
    | path expand

    let path = open $favorite_paths_path
    | (
        tui split --sizes [40% 1fr]
        [
            (
                tui split --vertical --sizes [3 1fr] [
                    (tui search --focus)
                    (tui table)
                ]
            )
            (
                tui preview {|row|
                    let dir = $row

                    ls $dir
                    | get name
                    | path relative-to $dir
                    | str join "\n"
                }
            )
        ]
    )
    | tui run
    | get selected

    if ($path | is-empty) {
        return
    }

    commandline edit $"cd '($path)'" --accept
}
