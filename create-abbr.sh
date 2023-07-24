#!/usr/bin/fish

while read -la line
    if string match -rq '#' "$line"
        continue
    else
        echo $line >> ~/.config/fish/config.fish
    end
end < ./fish-abbreviations.txt