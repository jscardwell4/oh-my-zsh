# autoload some functions
for f in $ZSH/(functions|completions)/*; autoload +X -U ${f:t}

autoload -U run-help zed

# set some function hooks
ls_hook(){eval 'ls'}; chpwd_functions=($chpwd_functions ls_hook)
