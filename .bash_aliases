# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -FlAh'
#alias la='ls -A'
#alias l='ls -CF'

# GIT aliases
alias g='git'
alias gcm='git checkout master'
alias gs='git status'

# vim aliases
alias v='vim'
alias vg='gvim'
alias nv='nvim'

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.less_termcap ]] && . ~/.less_termcap

export MANPAGER='less -X -s -M +Gg'

