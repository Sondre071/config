export def main [] {
    const snippets_path = '~/.config/terminal/snippets'
    | path expand

    let path = ls $snippets_path
    | rename --column { name: path }
    | insert name {|row|
        $row.path
        | path basename
    }
    | (tui split --sizes [40% 1fr]
            [(tui table --columns [name size])
            (tui preview {|row| open $row.path})]
    )
    | tui run
    | get selected
    | get -o path

    if ($path | is-empty) {
        return
    }

    open --raw $path
    | clip copy
}
