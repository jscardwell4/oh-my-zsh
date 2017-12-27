#syntax: shell

xcnuke() {
  emulate -L zsh

  rm -rf $(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache
  rm -rf ~/Library/Developer/Xcode/DerivedData/
  rm -rf ~/Library/Caches/com.apple.dt.Xcode
  print -- "Xcode has been nuked!"
}
