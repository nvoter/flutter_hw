import 'dart:math';
import '../../models/cat.dart';
import '../../models/liked_cat.dart';
import '../../services/api_service.dart';
import '../../services/likes_service.dart';

class HomeInteractor {
  final ApiService _apiService;
  final LikesService _likesService;
  List<String> _breedIds = [];
  final secureRandomizer = Random.secure();

  HomeInteractor(this._apiService, this._likesService);

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

  void addLike(Cat cat) {
    LikedCat likedCat = LikedCat(cat: cat, likeDate: DateTime.now());
    _likesService.addLike(likedCat);
  }

  int getLikesCount() {
    return _likesService.getLikes().length;
  }
}
