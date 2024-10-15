import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_local_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class CryptocurrencyLocalDataSourceImpl
    implements CryptocurrencyLocalDataSource {
  final Box<CryptocurrencyModel> cryptocurrencyBox;

  CryptocurrencyLocalDataSourceImpl({
    required this.cryptocurrencyBox,
  });

  @override
  Future<List<CryptocurrencyModel>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    return cryptocurrencyBox.values.skip(start - 1).take(limit).toList();
  }
}
