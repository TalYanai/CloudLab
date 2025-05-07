import json
from contacts import Contact  # ודא שהקובץ נקרא contacts.py או contact.py בהתאם

class PhoneBook:
    def __init__(self, filename="contacts.json"):
        self.filename = filename
        self.contacts = []
        self.load()

    def add_contact(self, contact):
        self.contacts.append(contact)
        self.save()

    def search(self, keyword):
        keyword = keyword.lower()
        results = []
        for c in self.contacts:
            if (
                keyword in c.name.lower()
                or keyword in c.phone.lower()
                or keyword in c.email.lower()
                or keyword in c.address.lower()
                or (c.partner_name and keyword in c.partner_name.lower())
            ):
                results.append(c)
        return results

    def delete_by_name(self, name):
        self.contacts = [c for c in self.contacts if name.lower() not in c.name.lower()]
        self.save()

    def save(self):
        with open(self.filename, "w") as f:
            json.dump([c.to_dict() for c in self.contacts], f, indent=2)

    def load(self):
        try:
            with open(self.filename, "r") as f:
                data = json.load(f)
                self.contacts = [Contact.from_dict(item) for item in data]
        except FileNotFoundError:
            self.contacts = []

    def show_all(self):
        for contact in self.contacts:
            print(contact)
            print("-" * 30)
