import 'package:get_it/get_it.dart';
import '../data/database.dart';
import '../data/cats_dao.dart';
import '../services/connectivity_service.dart';
import '../services/likes_repository.dart';
import '../services/api_service.dart';
import '../services/url_launcher_service.dart';
import '../screens/home/home_interactor.dart';
import '../screens/home/home_presenter.dart';
import '../screens/home/contracts/home_view.dart';
import '../screens/detail/detail_interactor.dart';
import '../screens/detail/detail_presenter.dart';
import '../screens/detail/contracts/detail_view.dart';
import '../screens/likes/likes_interactor.dart';
import '../screens/likes/likes_presenter.dart';
import '../screens/likes/contracts/likes_view.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<CatsDao>(() => CatsDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<UrlLauncherService>(() => UrlLauncherService());

  getIt.registerLazySingleton<LikesRepository>(
    () => LikesRepository(getIt<CatsDao>()),
  );

  getIt.registerFactory<HomeInteractor>(
    () => HomeInteractor(
      getIt<ApiService>(),
      getIt<LikesRepository>(),
      getIt<CatsDao>(),
      getIt<ConnectivityService>(),
    ),
  );
  getIt.registerFactory<DetailInteractor>(
    () => DetailInteractor(getIt<UrlLauncherService>()),
  );
  getIt.registerFactory<LikesInteractor>(
    () => LikesInteractor(getIt<LikesRepository>()),
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
