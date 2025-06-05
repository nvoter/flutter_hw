import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hw1/screens/home/home_presenter.dart';
import 'package:hw1/screens/home/home_interactor.dart';
import 'package:hw1/screens/home/contracts/home_view.dart';
import 'package:hw1/models/cat.dart';
import 'package:hw1/models/breed.dart';

class _MockInteractor extends Mock implements HomeInteractor {}
class _MockView extends Mock implements HomeView {}

void main() {
  late _MockInteractor interactor;
  late _MockView view;
  late HomePresenter presenter;

  final breed = Breed(
    id: 'b',
    name: 'Breed',
    description: '',
    temperament: '',
    origin: '',
    lifeSpan: '',
    wikipediaUrl: '',
    dogFriendly: 0,
  );
  final cat = Cat(id: 'c', imageUrl: 'url', breed: breed);

  setUpAll(() {
    registerFallbackValue(cat);
  });

  setUp(() {
    interactor = _MockInteractor();
    view = _MockView();
    when(() => interactor.watchLikesCount())
        .thenAnswer((_) => const Stream<int>.empty());
    presenter = HomePresenter(interactor, view);
  });

  test('like triggers addLike', () async {
    when(() => interactor.getNextCat()).thenAnswer((_) async => cat);
    await presenter.loadNextCat();
    when(() => interactor.addLike(cat)).thenAnswer((_) async {});
    presenter.likeCat();
    verify(() => interactor.addLike(cat)).called(1);
  });

  test('dislike does not trigger addLike', () async {
    when(() => interactor.getNextCat()).thenAnswer((_) async => cat);
    await presenter.loadNextCat();
    presenter.dislikeCat();
    verifyNever(() => interactor.addLike(any()));
  });

  test('loadNextCat updates value and notifies', () async {
    var notified = false;
    when(() => interactor.getNextCat()).thenAnswer((_) async => cat);
    presenter.addListener(() => notified = true);
    await presenter.loadNextCat();
    expect(presenter.value, cat);
    expect(notified, true);
  });
}
