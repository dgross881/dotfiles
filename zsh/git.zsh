# No arguments: `git status`
# With arguments: acts like `git`
function g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

function prompt_git_status() {
  local git_status="$(cat "tmp/git-status-$$")"
  if print "$git_status" | grep -qF "Changes not staged"; then
    print "changed"
  elif print "$git_status" | grep -qF "Changes to be committed"; then
    print "staged"
  elif print "$git_status" | grep -qF "Untracked files"; then
    print "untracked"
  elif print "$git_status" | grep -qF "working directory clean"; then
    print "unchanged"
  fi
}

function prompt_git_relative_branch() {
  local git_status="$(cat "tmp/git-status-$$")"
  if print "$git_status" | grep -qF "Your branch is behind"; then
    print "behind"
  elif print "$git_status" | grep -qF "Your branch is ahead"; then
    print "ahead"
  fi
}

# opens vim with #conflicted plugin to help fix git conflicts 
# git conflicted 
conflicted() {
 vim +Conflicted
}

# Complete g like git
compdef g=git
