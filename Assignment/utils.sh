#!/bin/bash
#title             :utils.sh
#description       :reusable code
#author            :sagar_deotale
#version           :1.0
#=================================================

date_time=$(date +%Y-%m-%d-%H:%M)
email_list="/home/afour/sagard_Assignment/Assignment/email_list.txt"
user="root"
password="root"
selected_database="emp"
sql_query1="SELECT * FROM employees"

msg() {
    local message="$1"
    echo "$date_time - INFO - $message"
}

error_exist() {
    local message="$1"
    echo "$date_time - INFO - $message"
    exit 1
}

connect_to_mysql_server() {
  echo $(MYSQL_PWD=$password mysql --user=$user --database=$selected_database --html -e "$1")
}

sendemail() {
    local subj="$1"
    local cont="$2"
    echo "$1"
    echo "$2"
    while read -r email; do
        echo "$cont" | mail -a "Content-type: text/html" -s "$subj" $email
    done <"$email_list"
}
