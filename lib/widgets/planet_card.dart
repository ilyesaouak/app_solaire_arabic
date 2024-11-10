class Planet {
  final String name;
  final String description;
  final String image;

  Planet({
    required this.name,
    required this.description,
    required this.image,
  });

  // Convert Firestore document to a Planet instance
  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '', // Ensure 'image' is mapped here
    );
  }
}
