#!/bin/bash

# Default values
COMMIT_MSG="Auto-sync: $(date)"
FORCE_PUSH=false

usage() { 
    echo "Usage: $0 [-m <commit_message>] [-f] [-h]"
    echo "  -m  : Specify a custom commit message"
    echo "  -f  : Force push (use with caution!)"
    echo "  -h  : Show this help message"
}

while getopts ":m:fh" opt; do
    case "${opt}" in
        m)
            COMMIT_MSG=${OPTARG}
            ;;
    	f)
	    FORCE_PUSH=true
	    ;;
	h) 
	    usage
	    exit 0
	    ;;
        \?)
            echo "Invalid option: -$OPTARG\n" >&2
	    usage
            exit 1
	    ;;
    	:)
  	    echo "Option -$OPTARG requires an argument.\n" >&2
	    usage
	    exit 1
  	    ;;
    esac
done

# Remove the processed flags from the argument list
shift $((OPTIND -1))


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
    git commit -m "$COMMIT_MSG"

    if [ $? -ne 0 ]; then
        echo "{ERROR}: Commit failed. Please check the error message above."
	read -p "Press enter to exit..."
        exit 1
    fi

    echo ""
    echo "[ACTION] Pushing to GitHub..."

    if [ "$FORCE_PUSH" = true ]; then
        echo "[WARN] Force push enabled!"
        git push origin main --force
    else
        git push origin main
    fi

    echo "[SUCCESS] Local changes pushed to remote."
else
    echo "[STATUS] No local changes found."
    echo "[RESULT] Nothing to commit or push."
fi

echo ""
echo "=========================================="
echo "             SYNC FINISHED"
echo "=========================================="
