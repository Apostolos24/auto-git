#!/bin/bash

echo "=========================================="
echo "       STEP 1: PULL FROM REMOTE"
echo "=========================================="
echo ""

git pull

# Check exit code
if [ $? -ne 0 ]; then
    echo ""
    echo "{ERROR}: Pull failed. Please resolve conflicts manually."
    read -p "Press enter to exit..."
    exit 1
fi

echo ""
echo "=========================================="
echo "       STEP 2: PUSH TO REMOTE"
echo "=========================================="
echo ""

# Check if there are changes using porcelain (clean output)
if [ -n "$(git status --porcelain)" ]; then
    echo "[STATUS] Changes detected. Processing..."

    echo "[ACTION] Adding files..."
    git add .

    echo "[ACTION] Committing..."
    # Check if an argument ($1) was provided
    if [ -n "$1" ]; then
        # Use the custom message provided by the user
        commit_msg="$1"
    else
        # Default to the timestamp if no argument is given
        commit_msg="Auto-sync: $(date)"
    fi

    # Use the variable in the git command
    git commit -m "$commit_msg"

    if [ $? -ne 0 ]; then
        echo "{ERROR}: Commit failed. Please check the error message above."
	read -p "Press enter to exit..."
        exit 1
    fi

    echo ""
    echo "[ACTION] Pushing to GitHub..."
    git push

    echo "[SUCCESS] Local changes pushed to remote."
else
    echo "[STATUS] No local changes found."
    echo "[RESULT] Nothing to commit or push."
fi

echo ""
echo "=========================================="
echo "             SYNC FINISHED"
echo "=========================================="
read -p "Press enter to exit..."
