# syntax: shell
# adapted from powerline.zsh-theme

# establish colors
local gray_fg=$'%F{238}' gray_bg=$'%K{245}' white_fg=$'%F{255}' blue_fg=$'%F{004}' blue_bg=$'%K{004}' red_fg=$'%F{001}' red_bg=$'%K{001}' green_fg=$'%F{002}' green_bg=$'%K{002}' black_fg=$'%F{236}' yellow_fg=$'%F{011}'

: ${POWERLINE_DATE_FORMAT:=%D{%Y-%m-%d}}
: ${POWERLINE_RIGHT_B:=%D{%H:%M:%S}} && [[ "$POWERLINE_RIGHT_B" == "none" ]] && POWERLINE_RIGHT_B=""
case $POWERLINE_RIGHT_A in
    mixed )         POWERLINE_RIGHT_A="%(?."$POWERLINE_DATE_FORMAT".$red_fg✘ %?)" ;;
    exit-status )   POWERLINE_RIGHT_A="%(?.$green_fg✔ %?.$red_fg✘ %?)" ;;
    date )          POWERLINE_RIGHT_A="$POWERLINE_DATE_FORMAT" ;;
esac

(( ${+POWERLINE_HIDE_USER_NAME}  &&  ${+POWERLINE_HIDE_HOST_NAME}))  && POWERLINE_USER_NAME=""
(( ${+POWERLINE_HIDE_USER_NAME}  && !${+POWERLINE_HIDE_HOST_NAME}))  && POWERLINE_USER_NAME="@%M"
((!${+POWERLINE_HIDE_USER_NAME}  &&  ${+POWERLINE_HIDE_HOST_NAME}))  && POWERLINE_USER_NAME="%n"
((!${+POWERLINE_HIDE_USER_NAME}  && !${+POWERLINE_HIDE_HOST_NAME}))  && POWERLINE_USER_NAME="%n@%M"

((${+POWERLINE_FULL_CURRENT_PATH})) && POWERLINE_CURRENT_PATH="%3(/.%3~.%d)" || POWERLINE_CURRENT_PATH="%1~"

# setup enivornment for git_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX=$' \ue0a0 '
ZSH_THEME_GIT_PROMPT_SUFFIX=''
ZSH_THEME_GIT_PROMPT_DIRTY=${POWERLINE_GIT_DIRTY:- ✘ }
ZSH_THEME_GIT_PROMPT_CLEAN=${POWERLINE_GIT_CLEAN:- ✔ }
ZSH_THEME_GIT_PROMPT_ADDED=${POWERLINE_GIT_ADDED:-$green_fg✚ %f}
ZSH_THEME_GIT_PROMPT_MODIFIED=${POWERLINE_GIT_MODIFIED:-$blue_fg✹ %f}
ZSH_THEME_GIT_PROMPT_DELETED=${POWERLINE_GIT_DELETED:-$red_fg✖ %f}
ZSH_THEME_GIT_PROMPT_UNTRACKED=${POWERLINE_GIT_UNTRACKED:-$yellow_fg✭%f }
ZSH_THEME_GIT_PROMPT_RENAMED=${POWERLINE_GIT_RENAMED:-➜ }
ZSH_THEME_GIT_PROMPT_UNMERGED=${POWERLINE_GIT_UNMERGED:-═ }
ZSH_THEME_GIT_PROMPT_AHEAD='⬆ '
ZSH_THEME_GIT_PROMPT_BEHIND='⬇ '
ZSH_THEME_GIT_PROMPT_DIVERGED='⬍'


local larrow=$'\ue0b2' rarrow=$'\ue0b0'

# set git right or left info/status
if ((${+POWERLINE_SHOW_GIT_ON_RIGHT})) {
    POWERLINE_GIT_INFO_RIGHT=$gray_fg$larrow$black_fg$gray_bg$'$(git_prompt_info)'" "$gray_fg
} else {
    if ((${+POWERLINE_HIDE_GIT_PROMPT_STATUS})) {
        POWERLINE_GIT_INFO_LEFT=" "$blue_fg$gray_bg$rarrow$black_fg$gray_bg$'$(git_prompt_info)'$gray_fg
    } else {
        POWERLINE_GIT_INFO_LEFT=" "$blue_fg$gray_bg$rarrow$black_fg$gray_bg$'$(git_prompt_info)$(git_prompt_status)'$gray_fg
    }
}


if ((!$(id -u))) {
    POWERLINE_SEC1_BG=$red_bg
    POWERLINE_SEC1_FG=$red_fg
    POWERLINE_SEC1_TXT=$'%f'
} else {
    POWERLINE_SEC1_BG=$green_bg
    POWERLINE_SEC1_FG=$green_fg
    POWERLINE_SEC1_TXT=$'%f'
}

if (( ${+POWERLINE_DETECT_SSH} && ${+SSH_CLIENT})){
    POWERLINE_SEC1_BG=$red_bg
    POWERLINE_SEC1_FG=$red_fg
    POWERLINE_SEC1_TXT=$'%f'
}

PROMPT=$POWERLINE_SEC1_BG$POWERLINE_SEC1_TXT\ $POWERLINE_USER_NAME$POWERLINE_SEC1_FG$blue_bg$rarrow$white_fg$blue_bg\ $POWERLINE_CURRENT_PATH${POWERLINE_GIT_INFO_LEFT:-}$'%k'$rarrow$'%f '


((! ${+POWERLINE_NO_BLANK_LINE})) && PROMPT=$'\n'$PROMPT

if ((! ${+POWERLINE_DISABLE_RPROMPT})) {
    ((!${+POWERLINE_RIGHT_A} &&  ${+POWERLINE_RIGHT_B})) && RPROMPT="$POWERLINE_GIT_INFO_RIGHT"$gray_fg$larrow"%k"$black_fg$gray_bg" $POWERLINE_RIGHT_B %f%k"
    (( ${+POWERLINE_RIGHT_A} && !${+POWERLINE_RIGHT_B})) && RPROMPT="$POWERLINE_GIT_INFO_RIGHT"$gray_fg$larrow"%k"$gray_fg$gray_bg" $POWERLINE_RIGHT_A %f%k"
    (( ${+POWERLINE_RIGHT_A} &&  ${+POWERLINE_RIGHT_B})) && RPROMPT="$POWERLINE_GIT_INFO_RIGHT"$gray_fg$larrow"%k"$black_fg$gray_bg" ${POWERLINE_RIGHT_B:-} %f%"$gray_fg$larrow"%f"$gray_bg" $POWERLINE_RIGHT_A %f%k"
}
