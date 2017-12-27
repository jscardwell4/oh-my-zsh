# syntax: shell
# subl
# wraps subl command

# external command 'subl' usage:
# Sublime Text build 3059
#
# Usage: subl [arguments] [files]         edit the given files
#    or: subl [arguments] [directories]   open the given directories
#    or: subl [arguments] -               edit stdin
#
# Arguments:
#   --project <project>: Load the given project
#   --command <command>: Run the given command
#   -n or --new-window:  Open a new window
#   -a or --add:         Add folders to the current window
#   -w or --wait:        Wait for the files to be closed before returning
#   -b or --background:  Don't activate the application
#   -s or --stay:        Keep the application activated after closing the file
#   -h or --help:        Show help (this message) and exit
#   -v or --version:     Show version and exit
#
# --wait is implied if reading from stdin. Use --stay to not switch back
# to the terminal when a file is closed (only relevant if waiting for a file).
#
# Filenames may be given a :line or :line:column suffix to open at a specific
# location.

subl() {

    typeset -A layout

    zparseopts -D l:=layout

    local subl_command #echo_subl_command

    if [[ ${layout[-l]} == 2 ]]; then
        local set_layout focus_group move_to_group
        set_layout="set_layout {\"cols\":[0.0, 0.5, 1.0],\"rows\":[0.0, 1.0],\"cells\":[[0,0,1,1],[1,0,2,1]]}"
        focus_group="focus_group {\"group\":0}"
        move_to_group="move_to_group {\"group\":1}"
        subl_command="command subl $@; sleep 1; command subl --command ${(q)set_layout} --command  ${(q)focus_group} --command  ${(q)move_to_group}"
        if [[ ${+echo_subl_command} == 1 ]]; then
            print -- "subl_command: $subl_command"
        fi
        eval $subl_command
    else
        subl_command="command subl $@"
        if [[ ${+echo_subl_command} == 1 ]]; then
            print -- "subl_command: $subl_command"
        fi
        eval $subl_command
    fi

}