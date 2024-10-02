import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/core/util/connectivity_check.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';

class CryptocurrencyDataSourceImpl implements CryptocurrencyDataSource {
  final ApiService apiService;
  final Box<CryptocurrencyModel> cryptocurrencyBox;

  CryptocurrencyDataSourceImpl(
      {required this.apiService, required this.cryptocurrencyBox});

  @override
  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    bool isOnline = await checkConnectivity();
    if (isOnline) {
      final List<CryptocurrencyModel> cryptocurrencies =
          await apiService.fetchCryptocurrencies(start: start, limit: limit);
      return cryptocurrencies;
    } else {
      return await _fetchCryptocurrenciesFromHive(start: start, limit: limit);
    }
  }

  Future<List<CryptocurrencyModel>> _fetchCryptocurrenciesFromHive({
    required int start,
    required int limit,
  }) async {
    return cryptocurrencyBox.values.skip(start - 1).take(limit).toList();
  }
}
