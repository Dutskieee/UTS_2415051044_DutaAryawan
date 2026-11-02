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
    final String id = json['id']?.toString() ?? '0';
    final String name = json['name']?.toString() ?? 'Nama Tidak Tersedia';

    return Destination(
      id: id,
      name: name,
      location: 'Indonesia',
      imageUrl: 'https://picsum.photos/seed/${json['id']}/400/300',
      description:
          'Jelajahi destinasi wisata dan kebudayaan yang ada di provinsi ${json['name']}.',
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
