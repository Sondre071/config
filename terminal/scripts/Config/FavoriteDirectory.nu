const file_path = '~/.config/terminal/favorite_paths'
| path expand

open $file_path
| lines --skip-empty
| append (pwd | str replace --all '\' '/')
| uniq
| sort
| save -f $file_path

print "Path favorited."
