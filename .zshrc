# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/tavo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases

function parse_git_branch {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

function aliashelp {
  echo '** GIT **';
  echo 'gti -> "git"';
  echo 'gits -> "git checkout staging; git pull origin staging"';
  echo 'gitrs -> "git rebase staging"';
  echo 'gitf -> "git fetch origin <branch>; git co <branch>"';
  echo '** RX **';
  echo 'rxu -> "rx dev up"';
  echo 'rxd -> "rx dev down"';
  echo 'rxs -> "rx dev status"';
  echo 'usdb -> "rx remotedb password --name new-us-reporting | pbcopy"';
  echo 'cadb -> "rx remotedb password --name new-ca-reporting | pbcopy"';
  echo 'rxshell -> "rx st shell -b <branch>"';
  echo 'rxconsole -> "rx staging console -b <branch>"';
  echo 'rxeditenvvar -> "rx st env -b <branch>"'; 
  echo '** Rails **';
  echo 'up -> bundle install / yarn install / migrate with data / db test prepare';
  echo 'ruba -> run rubocop only on modified files';
  echo 'gqls -> "rails graphql:schema:dump"';
  echo 'tableplus -> open TablePlus';
}

# reload from zshrc
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

alias up='bundle install; yarn install; rails db:migrate:with_data; rails db:test:prepare'
alias ruba='{ git ls-files --other --exclude-standard;git ls-files -m;} | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop -A'

################################
# Fullscript/rx local aliases #
################################

# rx
alias rxu="rx dev up"
alias rxd="rx dev down"
alias rxs="rx dev status"
# connects to a review app shell
# needs a branch argument
rxshell () { rx st shell -b $@ }
# connects to a review app rails console
# needs a branch argument
rxconsole () { rx staging console -b $@ }
rxeditenvvar () { rx st env -b $@ }

alias gti="git"
alias gitrs="git rebase staging"
gitf () { git fetch origin $@; git co $@ }

function gits() {
  # $prev_branch = parse_git_branch();
  # echo parse_git_branch();
  git co staging;
  git pull origin staging;
  # git branch -d $prev_branch;
  # echo "TERMINE";
}

# regenerate gql schema (from Chantal)
alias gqls='rails graphql:schema:dump'

# generate password for read-only prod US db
alias usdb='rx remotedb password --name new-us-reporting | pbcopy'

# generate password for read-only prod CA db
alias cadb='rx remotedb password --name new-ca-reporting | pbcopy'

alias tableplus='export LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1; open -a TablePlus'

export JAVA_HOME=$HOME/Downloads/jdk-19.0.1.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
