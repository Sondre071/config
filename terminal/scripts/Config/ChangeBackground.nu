const file_path = '~/.config/terminal/background.json'
| path expand

def main [] {
    mut file = open $file_path

    let term_width = (term size).columns

    loop {
        print-status $file.image $file.brightness $file.saturation $term_width

        let key = input listen --types [key]

        match $key.code {
            '1' => {
                $file.brightness = $file.brightness + 0.01
                | math round --precision 2
            }
            '!' => {
                $file.brightness = $file.brightness - 0.01
                | math round --precision 2
            }
            '2' => {
                $file.saturation = $file.saturation + 0.01
                | math round --precision 2
            }
            '"' => {
                $file.saturation = $file.saturation - 0.01
                | math round --precision 2
            }
            'p' => {
                let paste = clip paste
                | str replace --all '\' '/'
                | str replace --all '"' ''
                
                $file.image = $paste
            }
            's' => {
                $file | save -f $file_path
            }
            'q' => {
                return
            }
        }
    }
}

def print-status [
    image: string
    brightness: float
    saturation: float
    term_width: int
] {
    let text = [
        $"(ansi yellow_bold)Image: (ansi white_bold)($image)(ansi reset)"
        $"(ansi yellow_bold)Brightness: (ansi white_bold)($brightness)(ansi reset)"
        $"(ansi yellow_bold)Saturation: (ansi white_bold)($saturation)(ansi reset)"
    ]
    | each {|s| $s | fill -w $term_width | str substring 0..($term_width - 1) }
    | str join "\n"

    print $"\x1b[3A($text)"
}
