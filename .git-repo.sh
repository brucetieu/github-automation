#!/bin/bash# 
function git_create_repo() {
    source .env

    if [[ $# -eq 0 ]] ; 
      then
        echo '========== No arguments supplied =========='
        return
    fi

    if [ "$#" -ne 2 ]; then
        echo "========== Illegal number of parameters. Specify path to a directory and name of the repo to create =========="
        return
    fi

    mkdir $1 || {
        echo "========== Can't create directory $1 =========="
        return 
    }
    echo "========== Created directory $1 =========="

    if [ ! -z "$3" ] # check if repo will be public or private
    then
        python create_repo.py --name $2 --private
    else
        python create_repo.py --name $2
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
    git remote add origin https://github.com/"${USERNAME}"/$2.git
    git push -u origin master
}