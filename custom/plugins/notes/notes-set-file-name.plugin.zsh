# syntax:shell

notes-set-file-name () {
    emulate -L zsh
    autoload -Uz read-from-minibuffer
    zle -K notes-normal-keymap
    local REPLY
    read-from-minibuffer "File name: "
    notes_file_name=$REPLY
}
