import 'package:get_it/get_it.dart';
import '../screens/likes/contracts/likes_view.dart';
import '../screens/likes/likes_interactor.dart';
import '../screens/home/home_presenter.dart';
import '../services/api_service.dart';
import '../services/likes_service.dart';
import '../services/url_launcher_service.dart';
import '../screens/detail/detail_interactor.dart';
import '../screens/detail/detail_presenter.dart';
import '../screens/detail/contracts/detail_view.dart';
import '../screens/home/contracts/home_view.dart';
import '../screens/home/home_interactor.dart';
import '../screens/likes/likes_presenter.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<UrlLauncherService>(UrlLauncherService());
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<LikesService>(LikesService());

  getIt.registerFactory<DetailInteractor>(
    () => DetailInteractor(getIt<UrlLauncherService>()),
  );
  getIt.registerFactory<HomeInteractor>(
    () => HomeInteractor(getIt<ApiService>(), getIt<LikesService>()),
  );
  getIt.registerFactory<LikesInteractor>(
    () => LikesInteractor(getIt<LikesService>()),
  );

  getIt.registerFactoryParam<HomePresenter, HomeView, void>(
    (view, _) => HomePresenter(getIt<HomeInteractor>(), view),
  );
  getIt.registerFactoryParam<DetailPresenter, DetailView, void>(
    (view, _) => DetailPresenter(getIt<DetailInteractor>(), view),
  );
  getIt.registerFactoryParam<LikesPresenter, LikesView, void>(
    (view, _) => LikesPresenter(getIt<LikesInteractor>(), view),
  );
}
