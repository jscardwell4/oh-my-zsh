#syntax: shell

replacetext() {
	emulate -L zsh

	if (( $# < 3 )) {
		print -- "usage: replacetext 'text-to-remove' 'text-to-insert' files"
	} else {
		local replace="$1" with="$2"
		shift; shift
		perl -pi -w -e "\'s/$replace/$with/g;\'" "$@"
	}

}
