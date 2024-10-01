import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';

class CryptocurrencyDataSource {
  final ApiService apiService;

  CryptocurrencyDataSource(this.apiService);

  Future<List<CryptocurrencyModel>> getCryptocurrencies(
      {required int start, required int limit}) async {
    final List<CryptocurrencyModel> cryptocurrencies =
        await apiService.fetchCryptocurrencies(start: start, limit: limit);
    return cryptocurrencies;
  }
}
