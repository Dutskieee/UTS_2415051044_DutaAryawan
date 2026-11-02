class Destination {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final String description;

  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      location: json['location'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}

