import 'package:get_it/get_it.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_data_source.dart';
import 'package:windmill_digital_poc/data/repositories/cryptocurrency_repository_impl.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/get_cryptocurrencies_use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<CryptocurrencyDataSource>(
      () => CryptocurrencyDataSource(
            getIt<ApiService>(),
          ));

  getIt.registerLazySingleton<CryptocurrencyRepository>(
      () => CryptocurrencyRepositoryImpl(
            getIt<CryptocurrencyDataSource>(),
          ));

  getIt.registerLazySingleton<GetCryptocurrenciesUseCase>(
      () => GetCryptocurrenciesUseCase(
            getIt<CryptocurrencyRepository>(),
          ));

  getIt.registerFactory(() => CryptocurrencyBloc(
        getIt<GetCryptocurrenciesUseCase>(),
      ));
}
