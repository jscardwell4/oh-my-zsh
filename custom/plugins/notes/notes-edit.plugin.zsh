# syntax:shell
# notes-edit

refresh_highlight() {
    integer i=0
    for task in ${(f)BUFFER}; {
        if [[ $task[1] =~ (☑|☐) ]] {
            integer s_idx=$i
            integer e_idx=$s_idx+$#task
            local attributes="fg=white"
            if [[ $task[1] == ☑ ]] {
                attributes='fg=green'
            }
            if [[ $task[3] == \* ]] {
                attributes="fg=yellow,underline"
            } elif [[ $task[3] == '?' ]] {
                attributes="fg=black"
            }
            region_highlight=($region_highlight "$s_idx $e_idx $attributes")
        }
        i+=${#task}+1
    }
    zle -R
}

notes-edit-init() {
    if [[ -z $BUFFER ]] {
        BUFFER="☐ "
        CURSOR=3
    } else {
        refresh_highlight
    }
}

notes-edit-add() {
    RBUFFER+=$'\n'         # add newline
    CURSOR=$#BUFFER        # move cursor to the end
    integer s_idx=$#BUFFER # capture index
    LBUFFER+=$'☐   '       # add ballot box and spaces
    CURSOR=$#BUFFER        # move cursor to the new end
    integer e_idx=$#BUFFER # capture ending index
    region_highlight=($region_highlight "$s_idx $e_idx fg=white")
    zle -R
}

notes-edit-toggle() {
    local previous_tasks="${LBUFFER%(☐|☑)*}" current_task="${(M)LBUFFER%(☐|☑)*}"
    if [[ $current_task[1] == ☐ ]] {
        if [[ $current_task[3] == \* ]] { current_task[3]=' ' }
        LBUFFER="$previous_tasks☑${current_task#☐}"
    } elif [[ $current_task[1] == ☑ ]] {
        LBUFFER="$previous_tasks☐${current_task#☑}"
    } else {
        return -1
    }
    refresh_highlight
}

notes-edit-undo() { zle undo; refresh_highlight }

notes-edit-purge() {
    local -a pruned_buffer
    integer i=1
    for task in ${(f)BUFFER}; {
        if [[ ! $task[1] =~ (☑) ]] {
            pruned_buffer[$i]="$task"
            i+=1
        }
    }

    BUFFER=${(F)pruned_buffer}
    refresh_highlight
    zle -R
}

notes-edit-highlight() {
    local previous_tasks="${LBUFFER%(☐|☑)*}" current_task="${(M)LBUFFER%(☐|☑)*}"
    if [[ $current_task[3] == \* ]] {
        current_task[3]=' '
        LBUFFER="$previous_tasks$current_task"
    } else {
        current_task[3]='*'
        LBUFFER="$previous_tasks$current_task"
    }
    refresh_highlight
}

notes-edit-hold() {
    local previous_tasks="${LBUFFER%(☐|☑)*}" current_task="${(M)LBUFFER%(☐|☑)*}"
    if [[ $current_task[3] == '?' ]] {
        current_task[3]=' '
        LBUFFER="$previous_tasks$current_task"
    } else {
        current_task[3]='?'
        LBUFFER="$previous_tasks$current_task"
    }
    refresh_highlight
}

notes-edit() {
    case ${WIDGET#notes-edit-} in
        init      ) notes-edit-init      ;;
        add       ) notes-edit-add       ;;
        toggle    ) notes-edit-toggle    ;;
        undo      ) notes-edit-undo      ;;
        highlight ) notes-edit-highlight ;;
        hold      ) notes-edit-hold      ;;
        purge     ) notes-edit-purge     ;;
        *         ) return -1            ;;
    esac
}
