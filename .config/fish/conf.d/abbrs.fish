status is-interactive || return

# ae edits the abbrs
abbr --add ae vim ~/.config/fish/conf.d/abbrs.fish

abbr --add gpo git push origin
abbr --add gp git pull
abbr --add g git
abbr --add gg git grep
abbr --add xp xclip -selection clipboard -o
abbr --add gih cd '$(git home)'
abbr --add dco docker compose
abbr --add dcol docker compose logs -f

# common speling(sic) fixes
abbr --add grpe grep
abbr --add maek make

# Way too much typing
if type -q intellij-idea-ultimate-edition then
  abbr --add idea intellij-idea-ultimate-edition
end

if type -q yadm then
    abbr --add ypo yadm push origin
end
