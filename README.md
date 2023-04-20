#!/bin/bash

#projectballin - contact database



reset

print_menu(){

echo "1. Search"

echo "2. Add"

echo "3. Delete"

echo "4. Modify"

echo "5. Exit"

}



search_record(){

                echo "Which employee record would you like to search for?"
                read -p "please enter name you would like to search for: " name
                result=$(grep -i "^$name" "CONTACT_FILE")
                if [ -z "$result" ]; then
                        echo "contact not found"
                else
                        echo "contact found"
                        echo "$result"
                fi
                #show when contact was added?
                #ask if they want to search for another contact?
}



add_record(){

 echo "New employee login ~ Please enter the following:"
                read -p "name: " name
                read -p "address: " address
                read -p "phone number: " phone
                read -p "email: " email
                read -p "employee id number:" id
                read -p "employee title:" title
                echo "uploading info..."
                echo "$name,$address,$phone,$email,$id,$title" >> "CONTACT_FILE"
                echo "Employee added successfully"

        }
                #ask if they want to add another contact?

delete_record(){

                echo "which record would you like to delete?"
                read -p "please enter name you would like to delete: " name
                result=$(grep -i "^$name" "CONTACT_FILE")
                if [ -z "$result" ]; then
                echo "Contact not found"
                else
                echo "Contact details:"
                echo "$result"
  fi
 #ask if they want to delete another record?
}



modify_record(){

                echo "Which record would you like to modify?"
                #ask if they want to modify another record?
}



echo "Welcome to Project Ballin Contact Database app v1!"

print_menu

read choice

while [ $choice -ne 5 ]

do

 if [ $choice -eq 1 ]

        then

                search_record

        elif [ $choice -eq 2 ]

        then

                add_record

        elif [ $choice -eq 3 ]

        then

                delete_record

        elif [ $choice -eq 4 ]

        then

                modify_record

 else

                exit 0

        fi

        print_menu
        read -p "what else would you like to do, make your choice: " choice

done










