import 'dart:math';
import '../../models/cat.dart';
import '../../services/api_service.dart';

class HomeInteractor {
  final ApiService _apiService = ApiService();
  List<String> _breedIds = [];
  final secureRandomizer = Random.secure();

  Future<void> fetchAllBreeds() async {
    final breeds = await _apiService.getAllBreeds();
    _breedIds = breeds.map((breed) => breed.id).toList();
    if (_breedIds.isEmpty) {
      throw Exception('Failed to fetch breeds');
    }
  }

  Future<Cat> getNextCat() async {
    if (_breedIds.isEmpty) {
      throw Exception('No breeds available');
    }

    int index = secureRandomizer.nextInt(_breedIds.length);
    final breedId = _breedIds[index];
    return await _apiService.getRandomCatByBreed(breedId);
  }
}
