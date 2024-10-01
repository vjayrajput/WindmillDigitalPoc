import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';

class GetCryptocurrenciesUseCase {
  final CryptocurrencyRepository repository;

  GetCryptocurrenciesUseCase(this.repository);

  Future<List<CryptocurrencyEntity>> call(
      {required int start, required int limit}) async {
    return await repository.fetchCryptocurrencies(start: start, limit: limit);
  }
}
