#!/usr/bin/env bash
set -e
if [ -z "$1" ]; then
  echo "Usage: $0 GITHUB_TOKEN [repo_name] [visibility]" >&2
  exit 1
fi
TOKEN=$1
REPO=${2:-novel}
VIS=${3:-public}
USER_API=$(curl -s -H "Authorization: token $TOKEN" https://api.github.com/user)
USERNAME=$(echo "$USER_API" | grep '"login"' | head -1 | sed -E 's/\s+"login": "([^"]+)",/\1/')
if [ -z "$USERNAME" ]; then
  echo "Failed to read username from token. Check token scope." >&2
  exit 2
fi
echo "Creating repo $USERNAME/$REPO (visibility: $VIS) ..."
DATA=$(jq -n --arg name "$REPO" --arg vis "$VIS" '{name:$name,private:($vis=="private")}')
resp=$(curl -s -H "Authorization: token $TOKEN" -d "$DATA" https://api.github.com/user/repos)
if echo "$resp" | grep -q '"full_name"'; then
  echo "Repository created: $(echo $resp | jq -r .full_name)"
else
  echo "Create failed: $resp" >&2
  exit 3
fi
# add remote and push
git remote add origin https://github.com/$USERNAME/$REPO.git || true
git branch -M main || true
GIT_ASKPASS=echo git push -u https://$USERNAME:$TOKEN@github.com/$USERNAME/$REPO.git main
echo "Pushed to GitHub (note: token used in push URL). Remove remote credentials after use if desired."
