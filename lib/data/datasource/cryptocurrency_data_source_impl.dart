import 'package:windmill_digital_poc/data/datasource/cryptocurrency_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';

class CryptocurrencyDataSourceImpl implements CryptocurrencyDataSource {
  final ApiService apiService;

  CryptocurrencyDataSourceImpl(this.apiService);

  @override
  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    final List<CryptocurrencyModel> cryptocurrencies =
        await apiService.fetchCryptocurrencies(start: start, limit: limit);
    return cryptocurrencies;
  }
}
