#!/bin/bash
#title             :delete_few_rows.sh
#description       :used to delete table rows randomly
#author            :sagar_deotale
#version           :1.0
#==================================================
. ./utils.sh --source-only

delete_table_data_randomly() {
    row_count=$(MYSQL_PWD=$password mysql --user=$user --database=$selected_database --skip-column-names -e "$1")
    if [ $row_count -ge 1 ]
    then
        random_id=$(seq -s, "$row_count" -1 $(shuf -i 1-"$row_count" -n 1))
        msg "--------------------Deleted Few records depend on where clause------------------------"
        $(connect_to_mysql_server "DELETE FROM employees WHERE id IN (${random_id})")
        emp_data=$( connect_to_mysql_server "$sql_query1")
        sendemail "Table Data After Rows Deletion." "$emp_data"
    else 
        error_exist "User Id Not Found."   
    fi    
}

main() {
    delete_table_data_randomly "SELECT COUNT(*)FROM employees"
}

main
