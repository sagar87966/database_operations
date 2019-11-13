# Shell script

Assignment1 and Assignment2

## Getting Started
1) Assignment 1
   --> script_one.sh
   
2) Assignment 2
   --> insert_data.sh
   --> email_list.txt
   --> employee_data1.csv
   --> read_few_rows.sh
   --> delete_few_rows.sh
   --> utils.sh (reusable code)
## Prerequisites
Assignment 1
   -->email service 

Assignment 2
   --> Mysql database server
   --> email service


## How to Use
Assignment 1
   --> /app/access.log file should be at root level 
   execute:- sudo bash ./script_one.sh
   
Assignment 2
   -->  employees_data.csv and email_list.txt same folder
   1)Schedule cronjob
   --> check for crontab is present or not using `crontab -l`
   --> set using `sudo crontab -e` 
     
     -> select the editor to edit the file and add the below command (e.g `*(Minute) *(Hour) *(Day of month) *(Month of Year) *(Day of week) <path/to/script>`)
       
          -> `0 15 * * * /bin/bash /home/afour/Assignment/insert_data.sh`
          
          -> `1 15 * * * /bin/bash /home/afour/Assignment/read_few_rows.sh`
          
          -> `2 15 * * * /bin/bash /home/afour/Assignment/delete_few_rows.sh`
          
       -> Save it
       
       -> mark all the file used in script at executable using `chmod u+x <file_name>`            
## 

## Versioning

1.0

## Authors

sagar_deotale
.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details



