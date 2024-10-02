import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/data/datasource/favorite_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class FavoriteDataSourceImpl implements FavoriteDataSource {
  final Box<CryptocurrencyModel> hiveBox;

  FavoriteDataSourceImpl(this.hiveBox);

  @override
  Future<List<CryptocurrencyModel>> getFavorites() async {
    return hiveBox.values.toList();
  }

  @override
  Future<void> saveFavorite(CryptocurrencyModel currency) async {
    await hiveBox.put(currency.id, currency);
  }

  @override
  Future<void> deleteFavorite(int currencyId) async {
    await hiveBox.delete(currencyId);
  }

  @override
  Future<bool> isFavorite(int currencyId) async {
    return hiveBox.containsKey(currencyId);
  }
}
