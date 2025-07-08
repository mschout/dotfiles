#
# git fzf hooks.
#
# keybindings:
#
# CTRL-G CTRL-F - Files listed in 'git status'
# CTRL-G CTRL-B - Branches
# CTRL-G CTRL-T - Tags
# CTRL-G CTRL-H - Commit Hashes
# CTRL-G CTRL-R - Remotes
#
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

git_fzf_files() {
  is_in_git_repo &&
    git -c color.status=always status --short |
    fzf --height 60% -m --ansi --nth 2..,.. | awk '{print $2}'
}

git_fzf_branches() {
  is_in_git_repo &&
    git branch -a -vv --color=always | grep -v '/HEAD\s' |
    fzf --height 60% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
    sed 's#^remotes/[^/]*/##'
}

git_fzf_tags() {
  is_in_git_repo &&
    git tag --sort -version:refname |
    fzf --height 60% --multi
}

git_fzf_hashes() {
  is_in_git_repo &&
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
    fzf --height 60% --ansi --no-sort --reverse --multi | grep -o '[a-f0-9]\{7,\}'
}

git_fzf_remotes() {
  is_in_git_repo &&
    git remote -v | awk '{print $1 " " $2}' | uniq |
    fzf --height 60% --tac | awk '{print $1}'
}

bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(git_fzf_files)\e\C-e\er"'
bind '"\C-g\C-b": "$(git_fzf_branches)\e\C-e\er"'
bind '"\C-g\C-t": "$(git_fzf_tags)\e\C-e\er"'
bind '"\C-g\C-h": "$(git_fzf_hashes)\e\C-e\er"'
bind '"\C-g\C-r": "$(git_fzf_remotes)\e\C-e\er"'
