import 'dart:math';
import '../../models/cat.dart';
import '../../models/breed.dart';
import '../../services/api_service.dart';
import '../../services/likes_repository.dart';
import '../../data/cats_dao.dart';
import '../../services/connectivity_service.dart';

class HomeInteractor {
  final ApiService _api;
  final LikesRepository _likesRepo;
  final CatsDao _dao;
  final ConnectivityService _connectivity;

  List<String> _breedIds = [];
  final _rnd = Random.secure();

  HomeInteractor(this._api, this._likesRepo, this._dao, this._connectivity);

  Future<void> fetchAllBreeds() async {
    if (!await _connectivity.isOnline) return;
    final breeds = await _api.getAllBreeds();
    _breedIds = breeds.map((e) => e.id).toList();
  }

  Future<Cat> getNextCat() async {
    if (await _connectivity.isOnline && _breedIds.isNotEmpty) {
      final breedId = _breedIds[_rnd.nextInt(_breedIds.length)];
      final cat = await _api.getRandomCatByBreed(breedId);
      await _dao.cacheCat(cat);
      return cat;
    }

    final cached = await _dao.getCachedCats();
    if (cached.isNotEmpty) {
      return cached[_rnd.nextInt(cached.length)];
    }

    return Cat(
      id: 'no_cache',
      imageUrl: 'assets/images/placeholder.png',
      breed: Breed(
        id: '',
        name: 'No chached cats',
        description: 'Connect to network to get cats',
        temperament: '',
        origin: '',
        lifeSpan: '',
        wikipediaUrl: '',
        dogFriendly: 0,
      ),
    );
  }

  Future<void> addLike(Cat cat) => _likesRepo.addLike(cat);
  Stream<int> watchLikesCount() => _likesRepo.watchLikes().map((l) => l.length);
}
