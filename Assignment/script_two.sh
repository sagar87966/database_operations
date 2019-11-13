#!/bin/bash
#title             :script_two.sh
#description       :used to insert data into table
#author            :sagar_deotale
#version           :1.0
#==========================================================================================
#set -e
IFS=","
touch /home/afour/Assignment/crontab.txt
date_time=$(date +%Y-%m-%d-%H:%M)
user="root"
password="root"
selected_database="emp"
employee_data="/home/afour/Assignment/employee_data1.csv"
email_list="/home/afour/Assignment/email_list.txt"
sql_cmd='MYSQL_PWD=$password mysql --user=$user --database=$selected_database -e'
sql_query1="select * from employees"
sql_query2="show tables like 'employees'"
sql_query3="create table employees(id INT NOT NULL AUTO_INCREMENT, name VARCHAR(30), position VARCHAR(30), salary INT, PRIMARY KEY (id))"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
SET='\033[0m'

msg() {
   local message="$1"
   echo "$date_time - INFO - $message"
}

connect_to_mysql_server() {
  echo $(MYSQL_PWD=$password mysql --user=$user --database=$selected_database --html -e "$1")
}

insert_one_row() {
   validate_table_data "$sql_query1"
   column=$(head -n 1 $employee_data)
   local i=0
   while read -r col1 col2 col3; do
      if [ "$i" -ge 1 ]; then
         msg "Rows are inserting one by one."
	 echo "$col1|$col2|$col3"
         connect_to_mysql_server "insert into employees(${column}) values('${col1}', '${col2}', ${col3})"
      fi
      ((i++))
   done <$employee_data
   echo -e "${BLUE}++++++++++++++++++++++++++ Inserted Data +++++++++++++++++++++++++++++"
   emp_data=$( connect_to_mysql_server  "$sql_query1")
   sendemail "Inserted Rows" "$emp_data"
}

validate_table_data() {
   table_data=$(MYSQL_PWD=$password mysql --user=$user --database=$selected_database --html -e "$sql_query1" )
   if [ "$table_data" ];
   then	   
      msg "------------------Table exist-------------------------------------"
   else   
      echo "----------------No table exist with this name--------------------"   
      $( connect_to_mysql_server "$sql_query3")
      msg "------------------Table created successfully------------------------------"
   fi
}

sendemail() {
   local subj="$1"
   local cont="$2"
   while read -r email; do
      echo "$cont" | mail -a "Content-type: text/html" -s "$subj" $email
   done <"$email_list"
   echo -e "${GREEN}Mail sent successfully."
}

main() {
   insert_one_row
}

main
