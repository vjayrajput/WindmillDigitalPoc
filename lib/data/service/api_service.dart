import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final Box<CryptocurrencyModel> cryptocurrencyBox;

  static const String apiUrl =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/map';
  static const String apiKey = '2592e201-7cb0-41b4-81d5-abacc60ac4ee';

  ApiService({required this.cryptocurrencyBox});

  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    try {
      final response = await _dio.get(
        apiUrl,
        queryParameters: {'start': start, 'limit': limit},
        options: Options(
          headers: {
            'X-CMC_PRO_API_KEY': apiKey,
          },
        ),
      );
      print("apiService response : ${response}");
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        // Save to Hive
        List<CryptocurrencyModel> cryptocurrencies =
            data.map((crypto) => CryptocurrencyModel.fromJson(crypto)).toList();
        for (var crypto in cryptocurrencies) {
          await cryptocurrencyBox.put(crypto.id, crypto);
        }
        return cryptocurrencies;
      } else {
        throw Exception(
            "${Strings.failedToLoadCryptocurrencies} ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      print("apiService error 1 : ${dioError}");
      rethrow;
    } catch (e) {
      print("apiService error 2 : ${e.toString()}");
      rethrow;
    }
  }
}
