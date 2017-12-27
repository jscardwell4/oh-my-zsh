# path
path=(/usr/local/bin /usr/local/sbin $path $HOME/bin $HOME/Software/ruby/bin)

# pythonpath
export -TU PYTHONPATH pythonpath
pythonpath=($pythonpath $HOME/.py)

# unique
typeset -U path manpath fpath helpdir

# maya
MAYA_VERSION=2015
export MAYA_VERSION

MAYA_INSTALL_PATH="/Applications/Autodesk/maya2015"
export MAYA_INSTALL_PATH

MAYA_LOCATION="${MAYA_INSTALL_PATH}/Maya.app/Contents"
export MAYA_LOCATION

path=($path "${MAYA_LOCATION}/bin")

MENTALRAY_LOCATION="/Applications/Autodesk/mentalrayForMaya2015"
export MENTALRAY_LOCATION

# GEM_HOME="${HOME}/Software/ruby"
# export GEM_HOME

# TOOLCHAINS=org.swift.3020160301a
# export TOOLCHAINS
# DEVELOPER_DIR=/Applications/Xcode-beta.app/Contents/Developer
# SDKROOT=/Applications/Xcode6-Beta2.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk
# export SDKROOT
# typeset -TU DYLD_LIBRARY_PATH dyld_library_path
# dyld_library_path=($dyld_library_path "${MAYA_LOCATION}/MacOS")
# export DYLD_LIBRARY_PATH

