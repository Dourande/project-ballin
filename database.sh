#!/bin/bas

#Project - contact database



reset

print_menu(){

echo "1. Search"

echo "2. Add"

echo "3. Delete"

echo "4. Modify"

echo "5. Menu"

echo "6. Exit"

}

search_record() {
    echo "Which criteria would you like to search by?"
    echo "1. Name"
    echo "2. Home Address"
    echo "3. Phone Number"
    echo "4. Email"
    echo "5. ID"
    read -p "Enter your choice: " search_choice
    
    case $search_choice in
        1)
            read -p "Enter the name to search for: " search_query
            result=$(grep -i "^$search_query," "CONTACT_FILE")
            ;;
        2)
            read -p "Enter the home address to search for: " search_query
            result=$(grep -i ",$search_query," "CONTACT_FILE")
            ;;
        3)
            read -p "Enter the phone number to search for: " search_query
            result=$(grep -i ",$search_query$" "CONTACT_FILE")
            ;;
        4)
            read -p "Enter the email to search for: " search_query
            result=$(grep -i ",$search_query" "CONTACT_FILE")
            ;;
        5)
            read -p "Enter the ID to search for: " search_query
            result=$(grep -iE "^$search_query,|,$search_query$" "CONTACT_FILE")
            ;;
        *)
            echo "Invalid choice"
            return
            ;;
    esac
    
    if [ -z "$result" ]; then
        echo "Contact not found"
    else
        echo "Contact found"
        echo "$result"
    fi
}

		#show when contact was added?
		#ask if they want to search for another contact?



add_record(){

                echo "Please enter the following:"
		read -p "name: " name
		read -p "home address: " address
		read -p "phone#: " phone
		read -p "email: " email
		read -p "ID (4 digits): " id
		if ! [[ "$id" =~ ^[0-9]{4}$ ]]; then
			echo "invalid ID format."
			echo "please enter a 4-digit number"
			return
		fi
		echo "uploading info..."
	      	sleep 2
		echo "$name,$address,$phone,$email,$id" >> "CONTACT_FILE"
		echo "contact added successfully"
			
	}
		#ask if they want to add another contact?

delete_record() {
  read -p "Enter the name of the contact to delete: " name
  if grep -iq "^$name" "CONTACT_FILE"; then
   # Use grep to create a temporary file with all lines except for the one matching the specified name
    grep -iv "^$name" "CONTACT_FILE" > "$CONTACT_FILE.temp"
    # Replace the original file with the temporary file
    mv "$CONTACT_FILE.temp" "CONTACT_FILE"
    echo "Contact deleted successfully"
  else
    echo "Contact not found"
  fi	
		#ask if they want to delete another record?
}



modify_record(){
read -p "Enter the name of the contact to modify: " name
echo "searching for contact..."
sleep 2
  result=$(grep -i "^$name" "CONTACT_FILE")
  if [ -z "$result" ]; then
    echo "Contact not found"
  else
    echo "Current contact details:"
    echo "$result"
    read -p "Enter the new name (leave blank to keep current name): " new_name
    read -p "Enter the new home address (leave to keep current address:) " new_home
	read -p "Enter the new phone#(leave blank to keep the current phone#): " new_phone
    read -p "Enter the new email address (leave blank to keep the current email): " new_email
    read -p "Enter the new ID (4 digits): " new_ID
 if [ -z "$new_name" ]; then
      new_name=$(echo "$result" | cut -d',' -f1)
    fi
    if [ -z "$new_home" ]; then
      new_home=$(echo "$result" | cut -d',' -f2)
    fi
    if [ -z "$new_phone" ]; then
      new_phone=$(echo "$result" | cut -d',' -f3)
    fi
    if [ -z "$new_email" ]; then
      new_email=$(echo "$result" | cut -d',' -f4)
    fi
    if [ -z "$new_ID" ]; then
      new_ID=$(echo "$result" | cut -d',' -f5)
    fi
	

    sed -i "s/^$name,.*/$new_name,$new_home,$new_phone,$new_email,$new_ID/" "CONTACT_FILE"
    echo "modifying contact..."
    sleep 2
    echo "Contact modified successfully"
  fi
}




echo "Welcome to Ballin Employee Registration Database app v1!"

print_menu

read choice

while [ $choice -ne 6 ]

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

	elif [ $choice -eq 5 ]

	then
		print_menu
        else

                exit 0

        fi

	read -p "what else would you like to do, make your choice: " choice
	
done
