import 'package:dio/dio.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class ApiService {
  final Dio _dio = Dio();

  static const String apiUrl =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/map';
  static const String apiKey = '2592e201-7cb0-41b4-81d5-abacc60ac4ee';

  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    final response = await _dio.get(
      apiUrl,
      queryParameters: {'start': start, 'limit': limit},
      options: Options(
        headers: {
          'X-CMC_PRO_API_KEY': apiKey,
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data
          .map((crypto) => CryptocurrencyModel.fromJson(crypto))
          .toList();
    } else {
      throw Exception('Failed to load cryptocurrencies');
    }
  }
}
