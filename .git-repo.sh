#!/bin/bash# 
source "$(pwd)"/github-automation/.env

function git_create_repo() {

    if [[ $# -eq 0 ]] ; 
      then
        echo '========== No arguments supplied =========='
        return
    fi

    if [ "$#" -ne 3 ]; then
        echo "========== Illegal number of parameters. Specify path to a directory and name of the repo to create =========="
        return
    fi

    mkdir $1 || {
        echo "========== Can't create directory $1 =========="
        return 
    }
    echo "========== Created directory $1 =========="

    # Replace with CURL command
    if [ ! -z "$3" ] # check if repo will be public or private
    then
        curl \
        -X POST \
        -H "Authorization: token ${TOKEN}" \
        -d '{ "name": "'$2'", "private": true }' \
        https://api.github.com/user/repos
        # python "$(pwd)"/github-automation/create_repo.py --name $2 --private
    else
        # python "$(pwd)"/github-automation/create_repo.py --name $2
        curl \
        -X POST \
        -H "Authorization: token ${TOKEN}" \
         -d '{ "name": "'$2'", "private": false }' \
        https://api.github.com/user/repos
    fi

    cd $1 || {
        echo "========== Can't cd into directory $1 ==========" 
        return
    }       
    echo "========== Changed directory to $1 ==========" 

    touch README.md
    
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M master
    git remote add origin https://github.com/"${GITUSER}"/$2.git
    git push -u origin master
}
