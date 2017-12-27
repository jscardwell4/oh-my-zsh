# syntax: shell

alias run-help >&/dev/null && unalias run-help

# aliases from $ZDOT/zshrc.d/020_aliases.main.zsh
# alias lsa='ls -AFlh'
# alias lsd='ls -AFldh'
# alias pdsa='ps -axww'
# alias psa='ps -auxww'
# alias psl='ps -alxww'
# alias psj='ps -axjww'
# alias pso='ps -axwwo uid,pid,ppid,pgid,pri,nice,state,time,%cpu,%mem,command'

# aliases from $ZDOT/zshrc.d/021_aliases.additional.zsh
alias fu='sudo $( fc -ln -1)'
alias safari="open -a Safari"
alias photoshop="open -a Adobe\ Photoshop\ CC"
alias calc="open -a calculator"

if ((${+PORTPREFIX})) {
    alias portup='sudo port -d selfupdate; sudo port -d upgrade installed'
}

# alias swift2_2='/Library/Developer/Toolchains/swift-2.2-SNAPSHOT-2016-03-01-a.xctoolchain/usr/bin/swift'
# alias swift3='/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a.xctoolchain/usr/bin/swift'

# alias ldirs='dirs -v'
alias ls='ls -FGLH'
# alias ll='ls -lFho'
# alias l@='ll -@'
# alias ldirs='ls | grep -e '$'".*/"'
# alias grep='grep --color=auto -in'
# alias cp='cp -iv'
# alias del='rm -i'
# alias rm='rmm'
# alias mv='mv -iv'
# alias ipython="ipython --classic"
alias sed="sed -E"
# alias mayaterm='maya -prompt'
# alias swift='/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin/swift'
