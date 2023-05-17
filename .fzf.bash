# Setup fzf
# ---------
if [[ ! "$PATH" == */home/daniel/.fzf/bin* ]]; then
  export PATH="$PATH:/home/daniel/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/daniel/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/daniel/.fzf/shell/key-bindings.bash" 2>/dev/null || true
source "/usr/share/fzf/key-bindings.bash" 2> /dev/null


# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

# fman - search man
fman() {
  local manpage
  manpage=$(man -k . | sort | fzf --preview='echo {} | awk '\''{print($2," ",$1)}'\'' | sed "s/[\(|\)]//g" | xargs man')
  echo "$manpage" | awk '{print($2," ",$1)}' | sed 's/[\(|\)]//g' | xargs man
}


#ngrep tcp port
tngrep () {
   local tport
   tport=$(sudo ss -tlpn | sed '1d' | tr -s ' ' | fzf --preview='echo {} | cut -d ":" -f2 | cut -d " " -f1 | sudo xargs -IX ngrep -W byline -d any -q "" "tcp port X"' | cut -d ':' -f2 | cut -d ' ' -f1)
   sudo ngrep -W byline -d any -q '' "tcp port $tport"
}

# perf trace pid
ppid () {
   sudo ls >/dev/null || true
   local debugfs
   debugfs=$(mount | grep debugfs | cut -d ' ' -f3 | sort)
   local tracepoints
   tracepoints=$(sudo cat "${debugfs}/tracing/available_events" | fzf -m --preview='echo {} | sed "s/\:/\//g" | xargs -IX sudo cat "'${debugfs}'/tracing/events/X/format"')
   if [ -z "$2" ]; then
     sudo perf stat -a -v -e $(echo ${tracepoints} | tr -s ' ' ',') -p $1
   else
     sudo perf record -s -n --group -a -v -e $(echo ${tracepoints} | tr -s ' ' ',') -p $1 -o $2
   fi
}

# perf trace program
pstat () {
   sudo ls >/dev/null || true
   local debugfs
   debugfs=$(mount | grep debugfs | cut -d ' ' -f3 | sort)
   local tracepoints
   tracepoints=$(sudo cat "${debugfs}/tracing/available_events" | fzf -m --preview='echo {} | sed "s/\:/\//g" | xargs -IX sudo cat "'${debugfs}'/tracing/events/X/format"')
   sudo perf stat -v -e $(echo ${tracepoints} | tr -s ' ' ',')  "$@"
}

# ungrep- ngrep udp sockets
ungrep () {
   local filter
   filter=$(ss -au | grep -vi state | fzf -m | tr -s ' ' | cut -d ' ' -f4 | cut -d ':' -f1)
   ngrep -W byline -d any "$filter"
}

# mansysctl is used to attempt to generate docs for sysctl commands
# see: https://www.kernel.org/doc/Documentation/sysctl/kernel.txt
#mansysctl () {
#   local=vars
#   vars=$(sysctl -a | fzf -m --preview='cat /usr/src/linux/Documentation/* 2>/dev/null |xargs -IX sed -e "1,/{}/ d"')
#   echo $vargs
#}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

# pid trace per second
pidtrace () {
   local pid
   pid="$1"
   sudo ls >/dev/null || true
   local tracepoints
   tracepoints=$(sudo bpftrace -l | sed 's/[:]$//g' | fzf -m --preview='echo {} | xargs -IX sudo bpftrace -p '${pid}' -e "X { @counts = count(); } interval:s:1 { exit(); }"')
   sudo bpftrace -lv "$tracepoints"
   sudo bpftrace -p "${pid}" -e "${tracepoints}  { @counts = count(); } interval:s:1 { print(@counts); clear(@counts); }"
}

# pid symbol search
pidsymbol () {
   local pid
   pid="$1"
   cat /proc/$pid/maps | cut -c 74- | sort | uniq | sort -n | while read line; do nm /proc/$pid/root$line 2>/dev/null; done| fzf -m
}

pidreaddist() {
   local pid
   pid="$1"
   sudo ls >/dev/null || true
   sudo bpftrace -e "tracepoint:syscalls:sys_exit_read /pid == $pid / { @bytes = hist(args->ret); }"
}

