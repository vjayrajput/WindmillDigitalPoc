import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/core/network/api_endpoint.dart';
import 'package:windmill_digital_poc/core/network/api_params.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class ApiService {
  final Dio dio;

  final Box<CryptocurrencyModel> cryptocurrencyBox;

  String secretKey = dotenv.env['SECRET_KEY'] ?? '';

  ApiService({required this.dio, required this.cryptocurrencyBox});

  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    try {
      final response = await dio.get(
        ApiEndpoint.cryptocurrencyMap,
        queryParameters: {ApiParams.start: start, ApiParams.limit: limit},
        options: Options(
          headers: {
            ApiParams.headerProApiKey: secretKey,
          },
        ),
      );
      print("apiService response : $response");
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
      print("apiService error 1 : $dioError");
      rethrow;
    } catch (e) {
      print("apiService error 2 : ${e.toString()}");
      rethrow;
    }
  }
}
