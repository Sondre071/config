export def main [] {
    const favorite_paths_path = '~/.config/terminal/favorite_paths'
    | path expand

    let path = open $favorite_paths_path
    | lines
    | input list --fuzzy 'Move to path'

    if ($path | is-empty) {
        return
    }

    commandline edit $"cd ($path)" --accept
}
