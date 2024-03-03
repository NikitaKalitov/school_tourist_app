class Hotel {
  int id;
  String image;
  String title;
  String address;
  String phone;

  Hotel({
    required this.id,
    required this.image,
    required this.title,
    required this.address,
    required this.phone,
  });

  static Hotel fromMap(Map<String, dynamic> map) {
    return Hotel(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      address: map['address'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> hotelAsMap = {
      'id': id,
      'image': image,
      'title': title,
      'address': address,
      'phone': phone,
    };
    return hotelAsMap;
  }
}
