import '../../../models/cat.dart';

abstract class HomeView {
  void showCat(Cat cat);
  void showError(String message);
  void updateLikesCount(int likesCount);
  void navigateToDetail(Cat cat);
}
