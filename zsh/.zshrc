# Set filetype on editing. Use `\e` to open the editor from `psql`.
export PSQL_EDITOR="vim -c ':set ft=sql'"

# Path to zsh file
ZSH=~/.oh-my-zsh

# aliases 
alias vim='/usr/local/bin/vim'
alias erl='/usr/local/lib/erlang/erts-8.1/bin/erl'
alias dps='docker ps' alias vimelixir='vim -u ~/.vimrc.elixir' 
#source and open ~/.zshrc
alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias eclimd='~/java-neon/Eclipse.app/Contents/Eclipse/eclimd'

#exports 
export JAVA_HOME=$(/usr/libexec/java_home)
export EDITOR='atom -w'
export RBENV_ROOT=/usr/local/var/rbenv
export TERM=xterm
export MANPATH="/usr/local/man:$MANPATH"
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
export DOTFILES="~/.dotfiles"
export ECLIPSE_HOME="~/java-neon/Eclipse.app/Contents/Eclipse"
export SOURCE_ANNOTATION_DIRECTORIES='spec,vendor'
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:$PATH


for zsh_source in ~/.zsh/*.zsh; do
  source $zsh_source
done

#zsh themese && plugins
ZSH_THEME="robbyrussell"
plugins=(git) #git themed zsh plugin
source $ZSH/oh-my-zsh.sh
eval "$(rbenv init -)" 
