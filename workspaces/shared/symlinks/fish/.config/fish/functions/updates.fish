function labupdate
    if not test -e "/Users/anubis/dev/intellibus/lab/$(date +"%Y-%m-%d").md"
        touch "/Users/anubis/dev/intellibus/lab/$(date +"%Y-%m-%d").md"
        echo "# Update for $(date +"%Y-%m-%d")" >>"/Users/anubis/dev/intellibus/lab/$(date +"%Y-%m-%d").md"
    end
    code /Users/anubis/dev/intellibus/lab
    code "/Users/anubis/dev/intellibus/lab/$(date +"%Y-%m-%d").md"
    cd /Users/anubis/dev/intellibus/lab
end

function labpublish
    cd /Users/anubis/dev/intellibus/lab
    git add .
    git commit -S -m "docs: update for $(date +"%Y-%m-%d")"
    git push
end
