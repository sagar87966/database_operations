#!/bin/bash
#title             :read_few_rows.sh
#description       :used to read rows from table randomly
#author            :sagar_deotale
#version           :1.0
#===========================================================================================================
. ./utils.sh --source-only

read_table_data_randomly() {
    row_count=$(MYSQL_PWD=$password mysql --user=$user --database=$selected_database --skip-column-names -e "$1")
    echo "$row_count"
    if [ $row_count -ge 1 ]
    then
        random_id=$(seq -s, "$row_count" -1 $(shuf -i 1-"$row_count" -n 1))
        msg "--------------------Few records depend on where clause------------------------"
        emp_data=$( connect_to_mysql_server "SELECT * FROM employees WHERE id IN (${random_id})")
        sendemail "Some rows from table" "$emp_data"
    else 
        error_exist "Table Is Empty."   
    fi   
}

main() {
    read_table_data_randomly "select count(*) from employees"
}
main
