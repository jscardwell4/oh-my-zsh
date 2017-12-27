#!/usr/bin/env zsh -f

## autoload -U colors
# colors

function prompt_moondeer_help { print "nothing customizable yet"}

function prompt_moondeer_setup {
    PS1="%B%F{black}[%F{blue}%D{%I:%M%p}%F{black}]-[%F{green}%n%F{yellow}@%F{green}%m%F{black}]-[%F{magenta}%~%F{black}]%F{red}%(?..(%?%))%f%b
$ "
}

