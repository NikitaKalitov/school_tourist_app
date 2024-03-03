class Place {
  int id;
  String image;
  String title;
  String description;

  Place({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  static Place fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
    };
    return map;
  }
}
