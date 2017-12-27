# syntax:shell
# notes

notes() {

  emulate -L zsh

  # declare local parameters
  local note_content note_file_name curcontext=notes:::
  integer exit_status=0 TMOUT=0

  zstyle -m ":completion:notes:*" insert-tab '*' || zstyle ":completion:notes:*" insert-tab yes

  # make sure notes directory has been set and that it has been created
  [[ -e ${NOTESDIR:=$HOME/.notes} ]] || mkdir "$NOTESDIR"

  if ! bindkey -M notes >&/dev/null; {
    # create keymap and bind keys

    bindkey -N notes main                         # create keymap
    bindkey -A main notes-normal-keymap           # alias to main keymap
    bindkey -M notes "^M" notes-edit-toggle       # bind key for toggling task
    bindkey -M notes "^[P" notes-edit-purge       # bind key for purging completed tasks
    bindkey -M notes "^[*" notes-edit-highlight   # bind key for highlighting task
    bindkey -M notes "^[?" notes-edit-hold        # bind key for holding task
    bindkey -M notes "^[^M" notes-edit-add        # bind key for adding task
    bindkey -M notes "^xu" notes-edit-undo        # bind key to undo and redisplay
    bindkey -M notes "^X^W" accept-line           # bind key for accepting note


    autoload -Uz notes-set-file-name
    zle -N notes-set-file-name

    # make sure widgets have been created
    zle -N notes-edit-init notes-edit
    zle -N notes-edit-add notes-edit
    zle -N notes-edit-toggle notes-edit
    zle -N notes-edit-undo notes-edit
    zle -N notes-edit-purge notes-edit
    zle -N notes-edit-highlight notes-edit
    zle -N notes-edit-hold notes-edit

  }

  # parse parameters for delete or list options into associative array
  zparseopts -D -A opts c d l h

  if ((${+opts[-l]})) {
    # list note names and return if -l has been set

    list_notes

  } elif (( ${+opts[-h]} || $# != 1  )) {
    # print usage if there is not one parameter left with the note name

    [[$# != 1]] && exit_status=-1
    notes_usage

  } elif ((${+opts[-d]})) {
    # handle note deletion if -d has been set

    delete_note "$NOTESDIR/$1"

  } else {
    # edit note using vared and notes-edit widget

    edit_note "$NOTESDIR/$1"

  }

  return $exit_status

}


# notes_usage - print usage for the notes function
notes_usage() {
  print "usage: notes [-l]"
  print "             [-h]"
  print "             [-d] [name]"
  print "             [name]"
  print
  print "positional arguments:"
  print "    name        name of the note to show, edit, or delete"
  print
  print "optional arguments:"
  print "    -c          run in curses mode"
  print "    -l          list notes and exit"
  print "    -h          show this help message and exit"
  print "    -d          delete note with [name]"
}

list_notes() {
  # list_notes - list contents of NOTESDIR

  ls "$NOTESDIR" || exit_status=-1

}

delete_note() {
  # delete_note - prompt for confirmation and delete if the note exists

  if [[ ! -e "$1" ]] {

    print "unable to locate or remove a note named \'${1:t}\'"
    exit_status=-1

  } elif read -q '?are you sure? [y/n] '; {

    rm "$1" || exit_status=-1

  }

}

edit_note() {
  # edit_note - open the note to edit with vared

  # set local options
  setopt localoptions localtraps nobanghist

  # set parameter used by notes-set-file-name
  notes_file_name="$1"

  [[ -f "$1" ]] && note_content="$(<$1)"

  if (( ${+opts[-c]} )) {

    edit_note_curses

  } else {

    while vared -M notes -i notes-edit-init note_content
    do

      {

        print -r -- "$note_content" >| $notes_file_name

      } always {

        (( TRY_BLOCK_ERROR = 0 ))

      } && break

      echo -n -e '\a'

    done

  }

}

edit_note_curses_backspace() {

  local pos
  integer y x
  zcurses position stdscr pos

  y=$pos[1]
  x=$pos[2]

  if (( x > 0 )) {

    x=$x-1
    zcurses move stdscr $y $x
    zcurses char stdscr ' '
    zcurses move stdscr $y $x

  } elif (( y > 0 )) {

    x=pos[4]-1
    y=$y-1
    zcurses move stdscr $y $x
    zcurses char stdscr ' '
    zcurses move stdscr $y $x

  }

  # zcurses string stdscr "$pos"

}

edit_note_curses_toggle_emphasis() {

}

edit_note_curses_toggle_complete() {

}

edit_note_curses_move() {

  local pos
  zcurses position stdscr pos
  integer y=$pos[1] x=$pos[2]

  case $1 {
    u )
      y=$y-1
      zcurses move stdscr $y $x
      ;;
    d )
      y=$y+1
      zcurses move stdscr $y $x
      ;;
    l )
      x=$x-1
      zcurses move stdscr $y $x
      ;;
    r )
      x=$x+1
      zcurses move stdscr $y $x
      ;;
  }

}

edit_note_curses_exit() {

}

edit_note_curses_save_and_exit() {

}

edit_note_curses_add() {

  zcurses string stdscr $'\n'

  c_prev=""
}

edit_note_curses() {

  0=notes_curses           # update command name for widgets
  zmodload zsh/curses      # make sure module is loaded
  ttyctl -f                # freeze tty
  stty start 'undef'       # make ^Q available
  stty stop 'undef'        # make ^S available

  false && {
    # dump attributes, colors and keycodes

    local attrs=$zcurses_attrs colors=$zcurses_colors keycodes=$zcurses_keycodes
    print -- "command: $0"
    print -- "attributes:"
    print -l -- '\t'${^zcurses_attrs}
    print -- "colors:"
    print -l -- '\t'${^zcurses_colors}
    print -- "keycodes:"
    print -l -- '\t'${^zcurses_keycodes}

    return $exit_status
  }

  zcurses init                            # create stdscr
  trap 'zcurses end && return $@' INT     # set trap to cleanup
  local c_in c_prev k_in                  # declare locals

  while zcurses input stdscr c_in k_in; do     # input run loop

    if [[ -n $c_in ]] {

      case $c_in {

        $'\177' ) c_prev="" && edit_note_curses_backspace ;;
        $'\030' ) c_prev="CTRL_X" ;;
        $'\033' ) c_prev="META" ;;
        $'[A'   ) c_prev="" && edit_note_curses_move u ;;
        $'[B'   ) c_prev="" && edit_note_curses_move d ;;
        $'[C'   ) c_prev="" && edit_note_curses_move r ;;
        $'[D'   ) c_prev="" && edit_note_curses_move l ;;
        $'\027' ) [[ $c_prev == "CTRL_X" ]] && edit_note_curses_save_and_exit || c_prev="" ;;
        $'\021' ) [[ $c_prev == "CTRL_X" ]] && edit_note_curses_exit || c_prev="" ;;
        $'\0'   ) c_prev="" && edit_note_curses_toggle_emphasis ;;
        $'\n'   ) [[ $c_prev == "META" ]] && edit_note_curses_add || edit_note_curses_toggle_complete ;;
        *       ) c_prev="" && zcurses string stdscr $c_in ;;

      }

    } else {

      # zcurses string stdscr $k_in
      case $k_in {

        LEFT  ) edit_note_curses_move l ;;

        RIGHT ) edit_note_curses_move r ;;

        UP    ) edit_note_curses_move u ;;

        DOWN  ) edit_note_curses_move d ;;

      }

    }

  done

  zcurses end

}
