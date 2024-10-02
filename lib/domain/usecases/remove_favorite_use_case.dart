import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';

class RemoveFavoriteUseCase implements UseCase<void, int> {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase(this.repository);

  @override
  Future<void> call(int currencyId) {
    return repository.removeFavorite(currencyId);
  }
}
