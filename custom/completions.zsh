# syntax: shell

# was set by zsh-osx-templates (port)
# zstyle ':completion:*' menu select=10
# zstyle ':completion:*' completer _complete _correct _approximate _prefix
# zstyle ':completion::prefix-1:*' completer _complete
# zstyle ':completion:incremental:*' completer _complete _correct
# zstyle ':completion:predict:*' completer _complete
# zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST
# zstyle ':completion:*' expand 'yes'
# zstyle ':completion:*' squeeze-slashes 'yes'
# zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
# zstyle ':completion:*:matches' group 'yes'
# zstyle ':completion:*:descriptions' format "%B---- %d%b"
# zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
# zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
# zstyle ':completion:*:options' description 'yes'
# zstyle ':completion:*:options' auto-description '%d'
# zstyle ':completion:*:*:*:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*:*:cd:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*:*:open:*' matcher 'm:{a-z}={A-Z} r: ||[^ ]=**'
# zstyle ':completion:*' list-prompt '%S -- more -- %s'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:*:_mdfind:*' group-name ''


# set by oh-my-zsh
# zstyle ':completion::complete:*' cache-path /Users/Moondeer/.oh-my-zsh/cache/
# zstyle ':completion:*:*:*:*:processes' command 'ps -u Moondeer -o pid,user,comm -w -w'
# zstyle ':completion:*:hosts' hosts reciprocity.local github.com peacefulpathways.co www.peacefulpathways.co psalms.local peacefulpathways.com '[argouml-jenkins1.dyndns.org]:29418' 192.30.252.129 192.30.252.130 192.30.252.131 localhost broadcasthost localhost localhost silla silla localhost
# zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache avahi beaglidx bin cacti canna clamav daemon dbus distcache dovecot fax ftp games gdm gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust ldap lp mail mailman mailnull mldonkey mysql nagios named netdump news nfsnobody nobody nscd ntp nut nx openvpn operator pcap postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*:*:*:*:*' menu select
# zstyle '*' single-ignored show
# zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle -e :url-quote-magic url-globbers 'zmodload -i zsh/parameter;
#      reply=( noglob
#          ${(k)galiases[(R)(* |)(noglob|urlglobber|globurl) *]:-}
#          ${(k)aliases[(R)(* |)(noglob|urlglobber|globurl) *]:-} )'
# zstyle :urlglobber url-local-schema ftp file
# zstyle ':url-quote-magic:*' url-metas '*?[]^(|)~#{}='
# zstyle :urlglobber url-other-schema http https ftp
# zstyle -e ':url-quote-magic:*' url-seps 'reply=(";&<>${histchars[1]}")'
# zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion:*' users off
