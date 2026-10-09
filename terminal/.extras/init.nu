const current_file = path self | path expand
const current_dir = path self | path dirname

let target_dir = '~\.config\terminal' | path expand

ls $current_dir
| where name != $current_file
| each {|file|
    let target_path = $target_dir | path join ($file.name | path basename)

    if not ($target_path | path exists) {
        cp $file.name $target_path

        print $"(ansi green)File copied: (ansi white)($file.name | path basename)(ansi reset)"
    } else {
        print $"(ansi yellow)File already exists: (ansi white)($file.name | path basename)(ansi reset)"
    }
}
| ignore
