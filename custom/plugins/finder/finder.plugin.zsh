# syntax:shell

finder() {
  local file_path=$PWD
  if [[ $# > 0 ]]; then file_path="$1"; fi
  osascript <<-eof
tell app "Finder"
  activate
  open ("$file_path" as POSIX file)
end
eof
}

toggle_hidden() {

  if [[ `defaults read com.apple.finder AppleShowAllFiles` == "YES" ]] {

    defaults write com.apple.finder AppleShowAllFiles NO

  } else {

    defaults write com.apple.finder AppleShowAllFiles YES

  }

  killall Finder /System/Library/CoreServices/Finder.app

}
