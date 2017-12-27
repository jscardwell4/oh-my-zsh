#syntax: shell

gyb() {

    emulate -L zsh

    GYB=/Users/Moondeer/GitHub/swift_source_root/swift/utils/gyb

    for f in $@; {
      $GYB --line-directive "" -D CMAKE_SIZEOF_VOID_P=8 -o ${f:r} $f
    }

}
