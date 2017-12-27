# syntax:shell

med() {

	emulate -L zsh

	# make sure notes directory has been set and that it has been created
	[[ -e ${NOTESDIR:=$HOME/.notes} ]] || mkdir "$NOTESDIR"


	local var med_file_name
	local curcontext=med:::
	integer TMOUT=0


	zstyle -m ":completion:med:*" insert-tab '*' || zstyle ":completion:med:*" insert-tab yes

	if ! bindkey -M med >&/dev/null
	then
		# create keymap and bind keys
		bindkey -N med main                         # create keymap
		bindkey -A main med-normal-keymap           # alias to main keymap
		bindkey -M med "^M" notes-edit-toggle       # bind key for toggling task
		bindkey -M med "^ " notes-edit-highlight    # bind key for highlighting task
		bindkey -M med "^[^M" notes-edit-add        # bind key for adding task
		bindkey -M med "^xu" notes-edit-undo        # bind key to undo and redisplay
		bindkey -M med "^X^W" accept-line           # bind key for accepting note
		bindkey -M med "^[^[[A" notes-edit-move-up  # bind key for moving row up


		autoload -Uz med-set-file-name
		zle -N med-set-file-name

		# make sure widgets have been created
		zle -N notes-edit-init notes-edit
		zle -N notes-edit-add notes-edit
		zle -N notes-edit-toggle notes-edit
		zle -N notes-edit-undo notes-edit
		zle -N notes-edit-highlight notes-edit
		zle -N notes-edit-move-up notes-edit
	fi

	setopt localoptions nobanghist

	med_file_name=$1
	[[ -f $1 ]] && var="$(<$1)"
	while vared -M med var
	do
		{
			print -r -- "$var" >| $med_file_name
		} always {
			(( TRY_BLOCK_ERROR = 0 ))
		} && break
		echo -n -e '\a'
	done

	return 0

}