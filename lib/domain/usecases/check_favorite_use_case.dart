import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';

class CheckFavoriteUseCase implements UseCase<bool, int> {
  final FavoriteRepository repository;

  CheckFavoriteUseCase(this.repository);

  @override
  Future<bool> call(int currencyId) {
    return repository.isFavorite(currencyId);
  }
}
