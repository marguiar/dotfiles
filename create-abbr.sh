#!/usr/bin/fish

while read -la line
    if string match -rq '#' "$line"
        continue
    else
        $line
    end
end < ./fish-abbreviations.txt