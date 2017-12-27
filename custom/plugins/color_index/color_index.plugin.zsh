# syntax: shell

ms_print_usage() {
    print "Usage: color_index [(-k|--key)key] (FG|BG|FX|color)"
    print "                   (-s|--sgr)parameter"
    print "                   (-h|--help)"
    print "\nCommands:"
    print "\t -k|--key \t Key for which the corresponding value will be printed, if valid"
    print "\t FG|BG|FX|color\t Select which array to query"
    print "\t -s|--sgr \t With an argument, print the entry for the SGR parameter indicated"
    print "\t          \t Without an argument, print all the SGR parameter entries"
    print "\t          \t The arguments '38 and '48' are treated specially as follows:"
    print "\t          \t A color may be specified by appending '-' and a number [0..255], i.e. -s38-231"
    print "\t          \t All 256 colors may be printed by appending 'ls', i.e. -s38ls"
    print "\t          \t Testing a foreground color against a background color can be achieved with 't-fg-bg', i.e. -st-117-74"
    print "\t -h|--help \t Print this message and exit"
}

ms_print_sgr() {
    local -A sgr_parameters
    sgr_parameters=(
        $'0' $'Reset / Normal … all attributes off'
        $'1' $'Bold or increased intensity'
        $'2' $'Faint (decreased intensity) … not widely supported'
        $'3' $'Italic: on … not widely supported. Sometimes treated as inverse.'
        $'4' $'Underline: Single'
        $'5' $'Blink: Slow … less than 150 per minute'
        $'6' $'Blink: Rapid … MS-DOS ANSI.SYS; 150 per minute or more; not widely supported'
        $'7' $'Image: Negative … inverse or reverse; swap foreground and background (reverse video)'
        $'8' $'Conceal … not widely supported'
        $'9' $'Crossed-out … Characters legible, but marked for deletion. Not widely supported.'
        $'10' $'Primary(default) font'
        $'11' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'12' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'13' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'14' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'15' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'16' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'17' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'18' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'19' $'n-th alternate font … Select the n-th alternate font. 14 being the fourth alternate font, up to 19 being the 9th alternate font.'
        $'20' $'Fraktur hardly ever supported'
        $'21' $'Bold: off or Underline: Double … bold off not widely supported, double underline hardly ever'
        $'22' $'Normal color or intensity … neither bold nor faint'
        $'23' $'Not italic, not Fraktur'
        $'24' $'Underline: None … not singly or doubly underlined'
        $'25' $'Blink: off'
        $'26' $'Reserved'
        $'27' $'Image: Positive'
        $'28' $'Reveal … conceal off'
        $'29' $'Not crossed out'
        $'30' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'31' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'32' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'33' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'34' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'35' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'36' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'37' $'Set text color (foreground … 30 + x, where x is from the color table below'
        $'38' $'Set xterm-256 text color (foreground) … next arguments are 5;x where x is color index (0..255)'
        $'39' $'Default text color (foreground) … implementation defined (according to standard)'
        $'40' $'Set background color … 40 + x, where x is from the color table below'
        $'41' $'Set background color … 40 + x, where x is from the color table below'
        $'42' $'Set background color … 40 + x, where x is from the color table below'
        $'43' $'Set background color … 40 + x, where x is from the color table below'
        $'44' $'Set background color … 40 + x, where x is from the color table below'
        $'45' $'Set background color … 40 + x, where x is from the color table below'
        $'46' $'Set background color … 40 + x, where x is from the color table below'
        $'47' $'Set background color … 40 + x, where x is from the color table below'
        $'48' $'Set xterm-256 background color … next arguments are 5;x where x is color index (0..255)'
        $'49' $'Default background color … implementation defined (according to standard)'
        $'50' $'Reserved'
        $'51' $'Framed'
        $'52' $'Encircled'
        $'53' $'Overlined'
        $'54' $'Not framed or encircled'
        $'55' $'Not overlined'
        $'56' $'Reserved'
        $'57' $'Reserved'
        $'58' $'Reserved'
        $'59' $'Reserved'
        $'60' $'ideogram underline or right side line … hardly ever supported'
        $'61' $'ideogram double underline or double line on the right side … hardly ever supported'
        $'62' $'ideogram overline or left side line … hardly ever supported'
        $'63' $'ideogram double overline or double line on the left side … hardly ever supported'
        $'64' $'ideogram stress marking … hardly ever supported'
        $'90' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'91' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'92' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'93' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'94' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'95' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'96' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'97' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'98' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'99' $'Set foreground text color, high intensity … aixterm (not in standard)'
        $'100' $'Set background color, high intensity … aixterm (not in standard)'
        $'101' $'Set background color, high intensity … aixterm (not in standard)'
        $'102' $'Set background color, high intensity … aixterm (not in standard)'
        $'103' $'Set background color, high intensity … aixterm (not in standard)'
        $'104' $'Set background color, high intensity … aixterm (not in standard)'
        $'105' $'Set background color, high intensity … aixterm (not in standard)'
        $'106' $'Set background color, high intensity … aixterm (not in standard)'
        $'107' $'Set background color, high intensity … aixterm (not in standard)'
        $'108' $'Set background color, high intensity … aixterm (not in standard)'
        $'109' $'Set background color, high intensity … aixterm (not in standard)'
    )
    if [[ -n $1 ]] {
        if [[ $1 =~ (38|48) ]] {
            local -a keys
            keys=(${(s.-.)1})
            if (( ${#keys} == 2 )) {
                print -P -- "%{\e[${keys[1]};5;${keys[2]}m%}example%{\e[00m%}%f%k\t\t${sgr_parameters[${keys[1]}]}"
            } elif [[ $1 =~ (38|48)ls ]] {
                print -P -- "${sgr_parameters[${1%ls}]}"
                for (( i = 0; i < 256; i++ )); do
                    print -P -n -- "%{\e[${1%ls};5;${i}m%}${(l:3:)i}%f%k "
                    (( (i + 1) % 16 == 0 )) && print
                done
            } else {
                print -P -- "${sgr_parameters[${keys[1]}]}"
            }
            return 0
        } elif [[ $1 =~ t-* ]] {
            local -a keys
            keys=(${(s.-.)1})
            (( ${#keys} == 3 )) && print -P -- "%{\e[38;5;${keys[2]}m\e[48;5;${keys[3]}m%}example%{\e[00m%}%f%k" && return 0
            ms_print_usage && return -1
        } else {
            print -P -- "%{\e[$1m%}example%{\e[00m%}%f%k\t\t${sgr_parameters[$1]}" && return 0
        }
    }
    for key in ${(kon)sgr_parameters}; {
        print -lP -- "$key\t%{\e[${key}m%}example%{\e[00m%}%f%k\t\t${sgr_parameters[$key]}"
    }
}

color_index() {
    local -A opts
    zparseopts -M -D -A opts k: -key:=k s:: -sgr::=s h -help=h

    (( ${+opts[-h]} )) && ms_print_usage && return 0

    (( ${+opts[-s]} )) && ms_print_sgr ${opts[-s]}  && return 0

    local -a valid_arrays; valid_arrays=(BG FG FX color)
    local selected_array=${1:*valid_arrays}

    [[ -n $selected_array ]] || { ms_print_usage && return -1 }
    (( ${+opts[-k]} && ${+opts[-v]} )) && { ms_print_usage && return -1 }

    (( ${+opts[-k]} )) && {
        local key=${opts[-k]}
        print -- "key: $key"
        case $selected_array in
            FG )
                print -P -- "$key\t${(q)FG[$key]}\t${FG[$key]}color%f"
                ;;
            BG )
                print -P -- "$key\t${(q)BG[$key]}\t${BG[$key]}     %k"
                ;;
            FX )
                print -P -- "$key\t${(q)FX[$key]}\t${FX[$key]}effect%{\e[00m%}"
                ;;
        esac
        return 0
    }

    case $selected_array in
        FG )
            for key in ${(ko)FG}; {
                print -P -- $key$'\t'${(q)FG[$key]}$'\t'$FG[$key]'color'"%f"
            }
            ;;
        BG )
            for key in ${(ko)BG}; {
                print -P -- $key$'\t'${(q)BG[$key]}$'\t'$BG[$key]'     '"%k"
            }
            ;;
        FX )
            for key in ${(ko)FX}; {
                local tabs=$'\t'
                if (( $#key < 8 )) { tabs=$'\t\t' }
                print -P -- $key$tabs${(q)FX[$key]}$'\t'$FX[$key]'effect'"%{\e[00m%}"
            }
            ;;
        color )
            for key in ${(ko)color}; {
                print -P -- $key$'\t\t'$color[$key]
            }
            ;;
    esac
}

