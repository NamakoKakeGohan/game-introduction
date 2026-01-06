#!/bin/bash
cd /Users/namako-mac/game-introduction
echo "Waiting for GitHub repository to be created..."
for i in {1..60}; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://github.com/NamakoKakeGohan/game-introduction 2>/dev/null)
    if [ "$STATUS" = "200" ]; then
        echo "Repository found! Pushing..."
        git push -u origin main 2>&1
        if [ $? -eq 0 ]; then
            echo "Push successful!"
            git log --oneline
            exit 0
        fi
    else
        [ $((i % 10)) -eq 0 ] && echo "Waiting... (attempt $i/60)"
        sleep 2
    fi
done
echo "Repository not found. Please create it manually."
exit 1
