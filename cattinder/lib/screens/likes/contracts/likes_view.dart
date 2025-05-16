import '../../../models/cat.dart';

abstract class LikesView {
  void showError(String message);
  void navigateToDetail(Cat cat);
}
