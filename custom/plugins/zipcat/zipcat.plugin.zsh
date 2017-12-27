# syntax: shell

zipcat() {

    emulate -L zsh

    unzip -p $@ | less

}
