import './breed.dart';

class Cat {
  final String id;
  final String imageUrl;
  final Breed breed;

  Cat({required this.id, required this.imageUrl, required this.breed});

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breedJson = (json['breeds'] as List?)?.firstOrNull ?? {};
    final breed = Breed.fromJson(breedJson);

    return Cat(
      id: json['id'] as String? ?? '',
      imageUrl: json['url'] as String? ?? 'https://via.placeholder.com/300',
      breed: breed,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'url': imageUrl,
    'breeds': [breed.toJson()],
  };
}
