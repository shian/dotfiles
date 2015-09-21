## My theme for zsh

PROMPT='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}${PWD/#HOME/~}%b$(git_prompt_info)$(hg_prompt_info)
$(prompt_char)%{$reset_color%} '

function prompt_char {
   git branch >/dev/null 2>/dev/null && echo '±' && return
   hg root >/dev/null 2>/dev/null && echo '☿' && return
   echo '>'
}

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}[dirty]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}[untracked]"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[blue]%}<branch>%{$reset_color%}> \
< at %{$fg[blue]%}<status|modified|unknown>%{$reset_color%} >" 2>/dev/null
}

function prompt_clr {
    git branch >/dev/null 2>/dev/null && echo "%{$fg[red]%}" && return
    hg root >/dev/null 2>/dev/null && echo "%{$fg[blue]%}" && return
    echo "%{$fg[yellow]%}"
}

VIMODE='→'
function zle-line-init zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/:}/(main|viins)/→}"
 zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

function prompt_mode {
    echo "%{$fg[red]%}${VIMODE}"
}
