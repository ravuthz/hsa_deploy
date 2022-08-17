#!/bin/sh

FE_REMOTE=root@128.199.232.90
BE_REMOTE=root@128.199.232.90

printCenter() {
    # if length of arguments == 0 break these function
    [[ $# == 0 ]] && return 1

    # echo $@     ## list of all arguments
    # echo $#     ## length of all arguments

    declare TITLE=$1
    # get length of argument
    declare -i TITLE_LEN="${#TITLE}"
    # declare -i COLUMN_LEN="$(tput cols)"
    declare -i COLUMN_LEN="$(tput cols)"
    declare -i FILLER_LEN="$(( (COLUMN_LEN - TITLE_LEN) / 2 ))"

    # if arguments length >= 2 get first character of argument $2
    [[ $# -ge 2 ]] && TEXT="${2:0:1}" || TEXT=" "
    FILLTER_TEXT=""
    for (( i = 0; i < FILLER_LEN; i++ )); do
        FILLTER_TEXT="${FILLTER_TEXT}${TEXT}"
    done

    echo "$FILLTER_TEXT$TITLE$FILLTER_TEXT"
    # printf "\n%s%s%s" "$FILLTER_TEXT" "$TITLE" "$FILLTER_TEXT"
    # printf "%*s\n" $(((${#TITLE}+$COLUMN_LEN)/2)) "$TITLE"
}

printRLine() {
    [[ $# == 0 ]] && return 1

    declare TITLE=$1
    declare -i TITLE_LEN="${#TITLE}"
    declare -i COLUMN_LEN="$(tput cols)"
    declare -i FILLER_LEN="$(( (COLUMN_LEN - TITLE_LEN) / 2 ))"

    [[ $# -ge 2 ]] && TEXT="${2:0:1}" || TEXT="="
    FILLTER_TEXT=""
    for (( i = 0; i < FILLER_LEN; i++ )); do
        FILLTER_TEXT="${FILLTER_TEXT}${TEXT}"
    done

    echo "$TITLE$FILLTER_TEXT"
    # printf "\n%s%s" "$TITLE" "$FILLTER_TEXT"
}


printCenter " NOTE " "*"
printCenter " Before you wnat to deloy FE (Angular) "
printCenter " make sure you already build application "
printCenter " npm run build-prod "
printCenter " git add -f dist\ "
printCenter " then commit and push to server"
printCenter "" "*"


echo ""
echo "Enter number 1 to deploy FE ( Angular UI )"
echo "Enter number 2 to deploy BE ( Django API )"
echo "Press any key to cancel deploy this system"
echo ""
echo -n "Please select option to deploy: "
read options



deployFE() {
    printCenter " Deploy the FE (Angular) " "*"
        
    if [ -d "$FE_PATH" ]; then
        printRLine "Backup old directory ( ${FE_PATH} )"
        tar -zcvf "${FE_PATH}-$(date '+%Y-%m-%d-%H-%M-%S').tar.gz" $FE_PATH
        ls $FE_PATH

        printRLine "Delete old directory ( ${FE_PATH} )"
        rm -rf $FE_PATH
    else
        printRLine "The directory ( ${FE_PATH} ) doesn't exists"
    fi

    printRLine "Pull new code from git to directory ( ${FE_PROJECT} )"
    cd $FE_PROJECT
    git checkout .
    git checkout master
    git pull origin master

    if [ ! -d "$FE_PATH" ]; then
        mkdir $FE_PATH
    fi

    printRLine "Copy ${FE_PROJECT}/dist to $FE_PATH"
    cp -r ${FE_PROJECT}/dist/* $FE_PATH

    printRLine "Restart NGINX server"
    sudo service nginx restart
    sudo service nginx status
    exit 1
}

case $options in
    [1] )
        clear
        # ssh $FE_REMOTE "$(typeset -f printCenter); $(typeset -f printRLine); $(typeset -f deployFE); deployFE"
        ssh $FE_REMOTE 'bash -s' < deploy-fe.sh
        ;;
    [2] )
        clear
        echo "Deploy 2"
        ssh $BE_REMOTE 'bash -s' < deploy-be.sh
        ;;
    *) 
        # echo "Invalid option $options quit application"
        echo "Quit the application"
        break
        ;;
esac

# ssh root@128.199.232.90
# sudo -u postgres psql
# \c hsa_db
# DROP SCHEMA public CASCADE;
# CREATE SCHEMA public;

# http://linuxcommand.org/lc3_adv_tput.php
# https://stackoverflow.com/questions/22107610/shell-script-run-function-from-script-over-ssh