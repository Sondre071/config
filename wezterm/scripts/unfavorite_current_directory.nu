const favorite_paths_path = path self
| path dirname
| path dirname
| path dirname
| path join 'favorite_paths'

open $favorite_paths_path
| lines --skip-empty
| where $it != (pwd | str replace --all '\' '/')
| ($in | save -f $favorite_paths_path)

print "Path unfavorited."
