import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hw1/screens/likes/likes_presenter.dart';
import 'package:hw1/screens/likes/likes_interactor.dart';
import 'package:hw1/screens/likes/contracts/likes_view.dart';
import 'package:hw1/models/liked_cat.dart';
import 'package:hw1/models/cat.dart';
import 'package:hw1/models/breed.dart';

class _MockInteractor extends Mock implements LikesInteractor {}
class _MockView extends Mock implements LikesView {}

void main() {
  late _MockInteractor interactor;
  late _MockView view;
  late LikesPresenter presenter;

  final breed = Breed(
    id: 'b2',
    name: 'Breed2',
    description: '',
    temperament: '',
    origin: '',
    lifeSpan: '',
    wikipediaUrl: '',
    dogFriendly: 0,
  );
  final cat   = Cat(id: 'c2', imageUrl: 'url', breed: breed);
  final liked = LikedCat(cat: cat, likeDate: DateTime.now());

  setUpAll(() {
    registerFallbackValue(liked);
  });

  setUp(() {
    interactor = _MockInteractor();
    view = _MockView();
    presenter = LikesPresenter(interactor, view);
  });

  test('initialize fills notifier', () async {
    when(() => interactor.getLikedCats()).thenAnswer((_) async => [liked]);
    await presenter.initialize();
    expect(presenter.likesNotifier.value, [liked]);
  });

  test('removeLike updates list', () async {
    when(() => interactor.removeLike(liked)).thenAnswer((_) async {});
    when(() => interactor.getLikedCats()).thenAnswer((_) async => []);
    await presenter.removeLike(liked);
    verify(() => interactor.removeLike(liked)).called(1);
    expect(presenter.likesNotifier.value, []);
  });
}
