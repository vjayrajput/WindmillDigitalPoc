import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';

class WatchFavoritesUseCase
    implements UseCaseStream<List<CryptocurrencyEntity>, NoParams> {
  final FavoriteRepository repository;

  WatchFavoritesUseCase(this.repository);

  @override
  Stream<List<CryptocurrencyEntity>> call(NoParams params) {
    return repository.watchFavorites();
  }
}
