class Contact:
    def __init__(self, name, phone, email, address, partner_name=None):
        self.name = name
        self.phone = phone
        self.email = email
        self.address = address
        self.partner_name = partner_name

    def __str__(self):
        info = f"Name: {self.name}\nPhone: {self.phone}\nEmail: {self.email}\nAddress: {self.address}"
        if self.partner_name:
            info += f"\nPartner: {self.partner_name}"
        return info

    def to_dict(self):
        return {
            "name": self.name,
            "phone": self.phone,
            "email": self.email,
            "address": self.address,
            "partner_name": self.partner_name
        }

    @staticmethod
    def from_dict(data):
        return Contact(
            data["name"],
            data["phone"],
            data["email"],
            data["address"],
            data.get("partner_name")
        )
