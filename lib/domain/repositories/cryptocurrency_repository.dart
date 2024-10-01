import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';

abstract class CryptocurrencyRepository {
  Future<List<CryptocurrencyEntity>> fetchCryptocurrencies(
      {required int start, required int limit});
}
