import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';

class LoadFavoritesUseCase
    implements UseCase<List<CryptocurrencyEntity>, NoParams> {
  final FavoriteRepository repository;

  LoadFavoritesUseCase(this.repository);

  @override
  Future<List<CryptocurrencyEntity>> call(NoParams params) {
    return repository.loadFavorites();
  }
}
