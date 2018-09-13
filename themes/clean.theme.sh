# git theming
SCM_THEME_PROMPT_PREFIX="${bold_blue}(${yellow}"
SCM_THEME_PROMPT_SUFFIX="${bold_blue})${reset_color} "
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_DIRTY="${bold_red}✗"

PS1="${no_color}\u${reset_color}:${blue}\W/${reset_color} \[$(scm_prompt_info)\]${normal}$ "
