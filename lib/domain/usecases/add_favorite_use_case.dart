import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';

class AddFavoriteUseCase implements UseCase<void, CryptocurrencyEntity> {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  @override
  Future<void> call(CryptocurrencyEntity currency) {
    return repository.addFavorite(currency);
  }
}
