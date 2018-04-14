#!/bin/bash

if [ -z "$GH_TOKEN" ]; then
  echo "Missing GitHub token"
  exit 1
fi

if [ -z "$REMOTE" ]; then
  echo "Missing \$REMOTE"
  exit 1
fi

if [ -z "$WAIT" ]; then
  WAIT=10
fi

sleep $WAIT
git clone --depth=1 --branch=master "https://github.com/$REMOTE" remote
cd remote
git config user.name "SockPuppetry"
git config user.email "38356640+SockPuppetry@users.noreply.github.com"
echo "Committing from Travis CI build $TRAVIS_BUILD_NUMBER" >> output.txt
git add --all
git commit --message "Travis CI build $TRAVIS_BUILD_NUMBER"
git remote add target "https://${GH_TOKEN}@github.com/$REMOTE.git" >/dev/null 2>&1
git push --set-upstream target master >/dev/null 2>&1
