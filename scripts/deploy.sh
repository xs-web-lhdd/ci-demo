#!/bin/sh

set -e

pwd
remote=$(git config remote.origin.url)

echo 'remote is: '$remote

mkdir gh-pagaes-branch
cd gh-pagaes-branch

git config --global user.email "$GH_EMAIL" >/
dev/null 2>&1
git config --global user.name "$GH_NAME" >/
dev/null 2>&1
git init
git remote add --fetch origin "$remote"

echo 'email is :'$GH_EMAIL
echo 'name is :'$GH_NAME
echo 'sitesource is:'$sitesource

if git rev-parse --verify origin/gh-pages >/
dev/null 2>&1; then
  git checkout gh-pages
  git rm -rf .
else
  git checkout --orphan gh-pages
fi

cp -a "../${siteSource}/."

ls -la

git add -A
git commit --allow-empty -m "Deploy to Github pages [ci skip]"

git push --force --quiet origin gh-pages

cd ..
rm -rf gh-pages-branch

echo "Finshed Deployment!"