# syntax: shell

imgsize() {
    emulate -L zsh

    local -a opts
    zparseopts -M -D -a opts w h

    if [[ $opts =~ .*w.*h.* || $opts =~ .*h.*w.* ]] {
        print "usage:\timgsize [-w|-h] file(s)"
    } elif [[ $opts =~ .*w.* ]] {
        identify -format "%w\n" "$@"
    } elif [[ $opts =~ .*h.* ]] {
        identify -format "%h\n" "$@"
    } else {
        identify -format "%wx%h\n" "$@"
    }

}

exr_to_png() {

    emulate -L zsh

    for image in $@; do
        if [[ -r "$image" ]] convert "$image" "$image:r.png"
    done

}

imf_disp() {

    emulate -L zsh

    local cmd="$MENTALRAY_LOCATION/bin/imf_disp.app/Contents/MacOS/imf_disp"

    if [[ $# -eq 1 && -r $1 ]] {
        local w=$(( `imgsize -w "$1"` + 20 )) h=$(( `imgsize -h "$1"` + 20 ))
        $cmd --width=$w --height=$h "$1" &
    } else {
        $cmd "$1" &
    }

}

invert_image() {
  emulate -L zsh
  for image in $@; do
    if [[ -r "$image" ]] convert -negate "$image" "$image"
  done
}
