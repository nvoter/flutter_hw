class Breed {
  final String id;
  final String name;
  final String description;
  final String temperament;
  final String origin;
  final String lifeSpan;
  final String wikipediaUrl;
  final int dogFriendly;

  Breed({
    required this.id,
    required this.name,
    required this.description,
    required this.temperament,
    required this.origin,
    required this.lifeSpan,
    required this.wikipediaUrl,
    required this.dogFriendly,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? 'No description available',
      temperament: json['temperament'] as String? ?? 'Unknown',
      origin: json['origin'] as String? ?? 'Unknown',
      lifeSpan: json['life_span'] as String? ?? 'Unknown',
      wikipediaUrl: json['wikipedia_url'] as String? ?? 'Unknown',
      dogFriendly: json['dog_friendly'] as int? ?? 0,
    );
  }
}
