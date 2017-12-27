# syntax: shell
# markdown
# wraps markdown command

markdown() {

  emulate -L zsh

  local content="<html>\n$(command markdown $@)\n</html>\n"

  local tmpfile=$(mktemp /tmp/markdown$(date +%s).html)

  print "$content" > "$tmpfile"

  open -a Safari "$tmpfile"

}
