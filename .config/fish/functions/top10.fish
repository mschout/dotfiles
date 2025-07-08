function top10
    history | awk '{print $2}' | sort | uniq -c | sort -k1 -rn | head -10
end

