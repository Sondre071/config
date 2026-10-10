const file_path = '~/.config/terminal/favorite_paths'
| path expand

open $file_path
| lines --skip-empty
| where $it != (pwd | str replace --all '\' '/')
| str join "\n"
| collect # Collect is required when writing to the same file.
| save -f $file_path

print "Path unfavorited."
