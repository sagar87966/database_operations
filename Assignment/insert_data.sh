#!/bin/bash
#title             :insert_data.sh
#description       :used to insert data into table
#author            :sagar_deotale
#version           :1.0
#==========================================================================================
#set -e
IFS=","
employee_data="/home/afour/sagard_Assignment/Assignment/employees_data.csv"
sql_cmd='MYSQL_PWD=$password mysql --user=$user --database=$selected_database -e'
sql_query2="SHOW TABLES LIKE 'employees'"
sql_query3="CREATE TABLE employees(id INT NOT NULL AUTO_INCREMENT, name VARCHAR(30), position VARCHAR(30), salary INT, PRIMARY KEY (id))"

. ./utils.sh --source-only

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

insert_one_row() {
   validate_table_data "$sql_query1"
   column=$(head -n 1 $employee_data)
   local i=0
   while read -r col1 col2 col3; do
      if [ "$i" -ge 1 ]; then
         msg "Rows are inserting one by one."
	 echo "$col1|$col2|$col3"
         connect_to_mysql_server "INSERT INTO employees(${column}) VALUES('${col1}', '${col2}', ${col3})"
      fi
      ((i++))
   done <$employee_data
   echo -e "${BLUE}++++++++++++++++++++++++++ Inserted Data +++++++++++++++++++++++++++++"
   emp_data=$( connect_to_mysql_server  "$sql_query1")
   sendemail "Inserted Rows" "$emp_data"
}

validate_table_data() {
   table_data=$( connect_to_mysql_server "$sql_query1" )
   if [ "$table_data" ];
   then	   
      msg "------------------Table Exist-------------------------------------"
   else   
      echo "----------------No Table Exist With This Name--------------------"   
      $( connect_to_mysql_server "$sql_query3")
      msg "------------------Table Created Successfully------------------------------"
   fi
}

main() {
   insert_one_row
}

main
