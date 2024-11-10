class Planet {
  final String name;
  final String description;
  final String image;

  Planet({
    required this.name,
    required this.description,
    required this.image,
  });

  // Factory constructor to create a Planet object from a map
  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
