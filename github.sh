#!/bin/sh
# 
# github.sh
# - create a new repository in Github
#
# Copyright (C) 2015 Kenju - All Rights Reserved
# https://github.com/KENJU/git_shellscript 

# get user name
username=`git config github.user`
if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
fi

# get repo name
dir_name=`basename $(pwd)`
read -p "Do you want to use '$dir_name' as a repo name?(y/n)" answer_dirname
case $answer_dirname in
  y)
    # use currently dir name as a repo name
    reponame=$dir_name
    ;;
  n)
    read -p "Enter your new repository name: " reponame
    if [ "$reponame" = "" ]; then
        reponame=$dir_name
    fi
    ;;
  *)
    ;;
esac


# create repo
echo "Creating Github repository '$reponame' ..."
#curl -i -H "Authorization: token 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" -d '{"name": "'$reponame'", "auto_init": true, "private": true, "gitignore_template": "nanoc"}' https://api.github.com/user/repos
curl -i -H "Authorization: token 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" https://api.github.com/user/repos -d '{"name":"'$reponame'"}'
echo " done."

# create empty README.md
echo "Creating README ..."
touch README.md
echo " done."

# list all files on this directory
ls

# push to remote repo
echo "Pushing to remote ..."
git init
git add *
git commit -m "first commit"
git remote rm origin
git remote add origin git@github.com:$username/$reponame.git
#git remote add origin https://github.com/$username/$reponame.git
git push -u origin master
echo " done."

# open in a browser
read -p "Do you want to open the new repo page in browser?(y/n): " answer_browser

case $answer_browser in
  y)
    echo "Opening in a browser ..."
    open https://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@github.com/$username/$reponame
    ;;
  n)
    ;;
  *)
    ;;
esac
