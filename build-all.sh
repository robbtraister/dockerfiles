#!/bin/sh

docker pull alpine
docker pull debian

USERNAME=$(docker info 2> /dev/null | grep '^Username\: ' | sed -e 's/^Username\: *//')

function rebuild() {
  BRANCH=$1
  git checkout $BRANCH
  docker build -t $USERNAME/$BRANCH .
}

rebuild base
rebuild watcher
rebuild nginx
rebuild nginx-supervisor
rebuild nginx-watcher
rebuild nodejs
rebuild nodejs-supervisor
rebuild nodejs-watcher
rebuild phantomjs-base
git add -A
git commit -m "updated build"
git push
rebuild phantomjs
rebuild phantomjs-supervisor
git checkout phantomjs-watcher
git merge phantomjs-base
rebuild phantomjs-watcher

git checkout master
