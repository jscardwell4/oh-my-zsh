psearch() {
  local EXPRESSION=$@
  ps -ax | grep -P "$EXPRESSION" | grep -v -e 'grep' | grep -P "$EXPRESSION"
}