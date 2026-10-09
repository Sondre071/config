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

    let content = open --raw $path
    
    # TO-DO
    # if $content =~ '<|@w+|>' {
    #   find matches and prompt the user to place in each value
    #   then place each value into its spot, copy to clipboard
    #   For example, a script can have a placeholder like: WHERE TenantId = <|@TenantId|>
    # }
    
    $content
    | clip copy
}
