const favorite_paths_path = path self
| path dirname
| path dirname
| path dirname
| path join 'favorite_paths'

open $favorite_paths_path
| lines --skip-empty
| append (pwd | str replace --all '\' '/')
| uniq
| sort
| save -f $favorite_paths_path

print "Path favorited."
