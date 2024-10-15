import 'package:windmill_digital_poc/data/datasource/cryptocurrency_remote_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';

class CryptocurrencyRemoteDataSourceImpl
    implements CryptocurrencyRemoteDataSource {
  final ApiService apiService;

  CryptocurrencyRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    return await apiService.fetchCryptocurrencies(start: start, limit: limit);
  }
}
