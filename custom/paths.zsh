
export CUDA_HOME=/usr/local/cuda
export -TU DYLD_LIBRARY_PATH dyld_library_path
dyld_library_path=($CUDA_HOME/lib $CUDA_HOME $CUDA_HOME/extras/CUPTI/lib $DYLD_LIBRARY_PATH)

export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH

path=($CUDA_HOME/bin /usr/local/bin /usr/local/sbin $path $HOME/bin $HOME/Software/ruby/bin ./)

# pythonpath
export -TU PYTHONPATH pythonpath
pythonpath=($pythonpath $HOME/.py)

# unique
typeset -U path manpath fpath helpdir

