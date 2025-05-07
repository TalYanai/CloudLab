from phonebook import PhoneBook
from contacts import Contact
from sample_contacts import sample_contacts


def main():
    pb = PhoneBook()
    for contact in sample_contacts:
            pb.add_contact(contact)
    print("📥 Sample contacts imported successfully!")

    while True:
        print("\n📱 Phone Book:")
        print("1. Add contact")
        print("2. Search contact")
        print("3. Delete contact")
        print("4. Show all")
        print("5. Exit")

        choice = input("Choose an option: ")

        if choice == "1":
            name = input("Name: ")
            phone = input("Phone: ")
            email = input("Email: ")
            address = input("Address: ")
            partner = input("Partner's name (optional): ")
            contact = Contact(name, phone, email, address, partner or None)
            pb.add_contact(contact)
            print("✅ Contact added.")
        elif choice == "2":
            keyword = input("🔍 Enter search keyword: ")
            results = pb.search(keyword)
            for c in results:
                print(c)
                print("-" * 30)
            if not results:
                print("❌ No contacts found.")

        elif choice == "3":
            name = input("Delete by name: ")
            pb.delete_by_name(name)
            print("🗑️ Contacts deleted.")

        elif choice == "4":
            pb.show_all()

        elif choice == "5":
            print("👋 Goodbye!")
            break

if __name__ == "__main__":
    main()
   