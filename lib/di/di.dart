import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/core/util/connectivity_check.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_local_data_source.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_remote_data_source.dart';
import 'package:windmill_digital_poc/data/datasource/favorite_local_data_source.dart';
import 'package:windmill_digital_poc/data/datasource/local/cryptocurrency_local_data_source_impl.dart';
import 'package:windmill_digital_poc/data/datasource/local/favorite_local_data_source_impl.dart';
import 'package:windmill_digital_poc/data/datasource/remote/cryptocurrency_remote_data_source_impl.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/models/platform_model.dart';
import 'package:windmill_digital_poc/data/repositories/cryptocurrency_repository_impl.dart';
import 'package:windmill_digital_poc/data/repositories/favorite_repository_impl.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/add_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/check_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/get_cryptocurrencies_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/load_favorites_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/remove_favorite_use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CryptocurrencyModelAdapter());
  Hive.registerAdapter(PlatformModelAdapter());

  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: dotenv.env['API_URL'] ?? '')),
  );

  getIt.registerSingleton<ConnectivityCheck>(
    ConnectivityCheck(),
  );

  // Register Hive Box
  getIt.registerSingletonAsync<Box<CryptocurrencyModel>>(
    () async => await Hive.openBox<CryptocurrencyModel>('favorites'),
    instanceName: 'favoritesBox',
  );
  getIt.registerSingletonAsync<Box<CryptocurrencyModel>>(
    () async => await Hive.openBox<CryptocurrencyModel>('cryptocurrencies'),
    instanceName: 'cryptocurrenciesBox',
  );

  await getIt.allReady();

  // Register Api Service
  getIt.registerLazySingleton<ApiService>(() => ApiService(
        dio: getIt<Dio>(),
        cryptocurrencyBox: getIt<Box<CryptocurrencyModel>>(
            instanceName: 'cryptocurrenciesBox'),
      ));

  // Register Data Source
  getIt.registerLazySingleton<CryptocurrencyLocalDataSource>(
      () => CryptocurrencyLocalDataSourceImpl(
            cryptocurrencyBox: getIt<Box<CryptocurrencyModel>>(
                instanceName: 'cryptocurrenciesBox'),
          ));
  getIt.registerLazySingleton<CryptocurrencyRemoteDataSource>(
      () => CryptocurrencyRemoteDataSourceImpl(
            apiService: getIt<ApiService>(),
          ));
  getIt.registerFactory<FavoriteLocalDataSource>(
    () => FavoriteLocalDataSourceImpl(
        favoriteBox:
            getIt<Box<CryptocurrencyModel>>(instanceName: 'favoritesBox')),
  );

  // Register Repository
  getIt.registerFactory<FavoriteRepository>(
    () => FavoriteRepositoryImpl(getIt<FavoriteLocalDataSource>()),
  );
  getIt.registerLazySingleton<CryptocurrencyRepository>(
      () => CryptocurrencyRepositoryImpl(
            localDataSource: getIt<CryptocurrencyLocalDataSource>(),
            remoteDataSource: getIt<CryptocurrencyRemoteDataSource>(),
            connectivityCheck: getIt<ConnectivityCheck>(),
          ));

  // Register Use Cases
  getIt.registerLazySingleton<GetCryptocurrenciesUseCase>(
      () => GetCryptocurrenciesUseCase(
            getIt<CryptocurrencyRepository>(),
          ));
  getIt.registerLazySingleton<AddFavoriteUseCase>(
      () => AddFavoriteUseCase(getIt<FavoriteRepository>()));
  getIt.registerLazySingleton<CheckFavoriteUseCase>(
      () => CheckFavoriteUseCase(getIt<FavoriteRepository>()));
  getIt.registerLazySingleton<LoadFavoritesUseCase>(
      () => LoadFavoritesUseCase(getIt<FavoriteRepository>()));
  getIt.registerLazySingleton<RemoveFavoriteUseCase>(
      () => RemoveFavoriteUseCase(getIt<FavoriteRepository>()));

  // Register Blocs
  getIt.registerFactory(() => CryptocurrencyBloc(
        getIt<GetCryptocurrenciesUseCase>(),
      ));
  getIt.registerFactory(() => FavoriteCurrencyBloc(
        addFavoriteUseCase: getIt<AddFavoriteUseCase>(),
        checkFavoriteUseCase: getIt<CheckFavoriteUseCase>(),
        loadFavoritesUseCase: getIt<LoadFavoritesUseCase>(),
        removeFavoriteUseCase: getIt<RemoveFavoriteUseCase>(),
      ));
}
