# Oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="re5et"
CASE_SENSITIVE="true"
zstyle ":omz:update" mode reminder
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
plugins=(git colored-man-pages)

source $ZSH/oh-my-zsh.sh

# Custom source-files
source ~/.shell-plugins/lscolors.sh

# Aliases
alias ls="ls --color=auto -lah"
alias update="sudo apt-get update; sudo apt-get upgrade -y; sudo apt-get autoremove -y; sudo apt-get autoclean -y"
alias cls="clear; ls"

# Foud from https://gist.github.com/hightemp/5071909#file-bash-aliases-L3
function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ]; then
      case $1 in
      *.tar.bz2) tar xvjf $1 ;;
      *.tar.gz) tar xvzf $1 ;;
      *.tar.xz) tar xvJf $1 ;;
      *.lzma) unlzma $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) unrar x -ad $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xvf $1 ;;
      *.tbz2) tar xvjf $1 ;;
      *.tgz) tar xvzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *.xz) unxz $1 ;;
      *.exe) cabextract $1 ;;
      *) echo "extract: "$1" - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}
alias extr="extract "

function extract_and_remove {
  extract $1
  rm -f $1
}
alias extrr="extract_and_remove "

# Scripts for clearing rust target dirs recursively
delete_target_directory() {
  local dir_path=$1
  if [ -d "$dir_path/target" ]; then
    echo "Deleting the 'target' directory from: $dir_path"
    rm -rf "$dir_path/target"
    return 0
  else
    echo "The 'target' directory does not exist in: $dir_path"
    return 1
  fi
}

loop_over_dirs() {
  if find $1 -mindepth 1 -maxdepth 1 -not -path '*/.*' | read; then
  else
    echo "Dir: $1 is empty. Skipping."
    return 0
  fi

  for dir in "$1"/*; do
    depth=$(($2 + 1))
    if [ -d "$dir" ]; then
      echo "Found directory: $dir"
      delete_target_directory "$dir"
      if [ $? -eq 1 ] && [ $depth -lt 4 ]; then
        loop_over_dirs "$dir" $depth
      fi
    fi
  done
}

remove_rust_dirs() {
  loop_over_dirs $PWD 0
}
