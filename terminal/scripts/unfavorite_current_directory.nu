const file_path = '~/.config/terminal/favorite_paths'
| path expand

open $file_path
| lines --skip-empty
| where $it != (pwd | str replace --all '\' '/')
| save -f $file_path

print "Path unfavorited."
