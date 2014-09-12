# fich's zshrc file based on:
# kcbanner's zshrc file v0.1, based on:
# jdong's zshrc file v0.2.1 and
# mako's zshrc file, v0.1

setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars interactive_comments no_prompt_cr
setopt   correctall autocd recexact longlistjobs nohup incappendhistory sharehistory extendedhistory
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes 
setopt   MAGIC_EQUAL_SUBST equals # Allow completion for args follow = symbol
setopt	 hist_ignore_dups # No historical duplicates in a row
unsetopt bgnice autoparamslash menucomplete #auto_menu

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -a zsh/mapfile mapfile

PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
TZ="Europe/Belfast"
HISTFILE=$HOME/.zhistory
HISTSIZE=10000000
SAVEHIST=10000000
HOSTNAME="`hostname`"
PAGER='less'
TERM='xterm-256color'
VISUAL='vim'
EDITOR='vim'
SHELL=`which zsh`
READNULLCMD='less'

# Use vi bindings
bindkey -v
# .1s transition between normal and insert mode
export KEYTIMEOUT=1
# Use emacs bindings
#bindkey -e

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/lib/

# Colours for man pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[01;32m' # begin underline


autoload colors zsh/terminfo
#if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
#fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done

PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="
[$PR_BLUE%n$PR_WHITE@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%~$PR_NO_COLOR%(1j. - %j job(s).)%(?.. ret %?)]
%(!.#.$) "
_RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M:%S})$PR_NO_COLOR"
RPS1=${_RPS1}
#LC_ALL='en_US.UTF-8'
#LANG='en_US.UTF-8'
#LC_CTYPE='en_US.UTF-8'
#LANGUAGE='en_US.UTF-8'


zle -N zle-line-init
zle -N zle-keymap-select
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $_RPS1"
    zle reset-prompt
}


unsetopt ALL_EXPORT
alias man='LC_ALL=C LANG=C man'

# You might say, since I work in QA, it always makes sense to have coredumps
ulimit -c unlimited

# fifo for use as a clipboard with associated aliases
[ -p /tmp/scratchboard ] || ( mkfifo /tmp/scratchboard && chmod 777 /tmp/scratchboard )

# 'version control', ie undo history files for vim
[ -d ~/vim_changes ] || ( mkdir -p ~/vim_changes )

if [[ -e ~/.zsh_local ]]; then
    source ~/.zsh_local
fi

# Source alias file
source ~/dotfiles/.zaliases
# Source enviroment settings
if [[ -e ~/dotfiles/.zenvironment ]]; then
    source ~/dotfiles/.zenvironment
fi

#############################
# Completion and that
#############################
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*' accept-exact false
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'

# New completion:
#  1. All /etc/hosts hostnames are in autocomplete
#  2. If you have a comment in /etc/hosts like #%foobar.domain,
#     then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')

# http://www.sourceguru.net/ssh-host-completion-zsh-stylee/
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin condor daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort kamailio

# SSH Completion
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# Automatically quote globs in URL and remote references
__remote_commands=(scp rsync)
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema '[[ $__remote_commands[(i)$words[1]] -le ${#__remote_commands} ]] && reply=("*") || reply=(http https ftp)'
