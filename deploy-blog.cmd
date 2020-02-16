@echo off

echo "Committing any master changes."
git checkout master
git commit -m %1

echo "Deleting old publication."
rd /s /q public
mkdir public
git worktree prune
rd /s /q .git/worktrees/public/

echo "Worktree addition."
git worktree add -B gh-pages public origin/gh-pages

echo "Cleaning public."
rd /s /q public/*

echo "Generating site."
hugo

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m %1

echo "Pushing to GitHub."
git push origin --all