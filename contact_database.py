import re

def print_menu():
    print("1. Search")
    print("2. Add")
    print("3. Delete")
    print("4. Modify")
    print("5. Menu")
    print("6. Exit")

def search_record():
    print("Which criteria would you like to search by?")
    print("1. Name")
    print("2. Home Address")
    print("3. Phone Number")
    print("4. Email")
    print("5. ID")
    search_choice = input("Enter your choice: ")

    with open("CONTACT_FILE", "r") as file:
        contacts = file.readlines()

    search_query = input("Enter the search query: ")

    if search_choice == "1":
        result = [contact for contact in contacts if re.search(f"^{search_query},", contact, re.IGNORECASE)]
    elif search_choice == "2":
        result = [contact for contact in contacts if re.search(f",{search_query},", contact, re.IGNORECASE)]
    elif search_choice == "3":
        result = [contact for contact in contacts if re.search(f",{search_query}$", contact, re.IGNORECASE)]
    elif search_choice == "4":
        result = [contact for contact in contacts if re.search(f",{search_query}", contact, re.IGNORECASE)]
    elif search_choice == "5":
        result = [contact for contact in contacts if re.search(f"^{search_query},|,{search_query}$", contact, re.IGNORECASE)]
    else:
        print("Invalid choice")
        return

    if not result:
        print("Contact not found")
    else:
        print("Contact found")
        print("".join(result))

def add_record():
    print("Please enter the following:")
    name = input("name: ")
    address = input("home address: ")
    phone = input("phone#: ")
    email = input("email: ")
    id = input("ID (4 digits): ")
    
    if not re.match(r"^\d{4}$", id):
        print("Invalid ID format.")
        print("Please enter a 4-digit number.")
        return

    with open("CONTACT_FILE", "a") as file:
        file.write(f"{name},{address},{phone},{email},{id}\n")

    print("Contact added successfully")

def delete_record():
    name = input("Enter the name of the contact to delete: ")
    with open("CONTACT_FILE", "r") as file:
        contacts = file.readlines()

    updated_contacts = [contact for contact in contacts if not re.search(f"^{name},", contact, re.IGNORECASE)]

    if len(contacts) == len(updated_contacts):
        print("Contact not found")
        return

    with open("CONTACT_FILE", "w") as file:
        file.writelines(updated_contacts)

    print("Contact deleted successfully")

def modify_record():
    name = input("Enter the name of the contact to modify: ")

    with open("CONTACT_FILE", "r") as file:
        contacts = file.readlines()

    matching_contacts = [contact for contact in contacts if re.search(f"^{name},", contact, re.IGNORECASE)]

    if not matching_contacts:
        print("Contact not found")
        return

    print("Current contact details:")
    print("".join(matching_contacts))

    new_name = input("Enter the new name (leave blank to keep current name): ")
    new_home = input("Enter the new home address (leave blank to keep current address): ")
    new_phone = input("Enter the new phone# (leave blank to keep the current phone#): ")
    new_email = input("Enter the new email address (leave blank to keep the current email): ")
    new_ID = input("Enter the new ID (4 digits): ")

    if not new_name:
        new_name = matching_contacts[0].split(",")[0]
    if not new_home:
        new_home = matching_contacts[0].split(",")[1]
    if not new_phone:
        new_phone = matching_contacts[0].split(",")[2]
    if not new_email:
        new_email = matching_contacts[0].split(",")[3]
    if not new_ID:
        new_ID = matching_contacts[0].split(",")[4].rstrip()

    updated_contact = f"{new_name},{new_home},{new_phone},{new_email},{new_ID}\n"
    updated_contacts = [updated_contact if contact.startswith(name) else contact for contact in contacts]

    with open("CONTACT_FILE", "w") as file:
        file.writelines(updated_contacts)

    print("Contact modified successfully")

while True:
    print_menu()
    choice = input("Enter your choice: ")

    if choice == "1":
        search_record()
    elif choice == "2":
        add_record()
    elif choice == "3":
        delete_record()
    elif choice == "4":
        modify_record()
    elif choice == "5":
        continue
    elif choice == "6":
        print("Exiting the program...")
        break
    else:
        print("Invalid choice. Please try again.")

