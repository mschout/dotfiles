status is-interactive || return

# ae edits the abbrs
abbr --add ae vim ~/.config/fish/conf.d/abbrs.fish

# Git related abbreviations
abbr --add g git
abbr --add gca git commit --amend --no-edit
abbr --add gg git grep
abbr --add gih cd '$(git home)'
abbr --add gp git pull
abbr --add gpo git push origin
abbr --add grh git reset HEAD

abbr --add xp xclip -selection clipboard -o

# Docker compose
abbr --add dco docker compose
abbr --add dcl docker compose logs -f

# common speling(sic) fixes
abbr --add grpe grep
abbr --add maek make

if type -q gvim && test -n "$DISPLAY"
    abbr --add gv gvim
end

# Way too much typing
if type -q intellij-idea-ultimate-edition then
  abbr --add idea intellij-idea-ultimate-edition
end

if type -q yadm then
    abbr --add ypo yadm push origin
end
