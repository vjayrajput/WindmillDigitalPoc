import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

abstract class CryptocurrencyDataSource {
  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit});
}
