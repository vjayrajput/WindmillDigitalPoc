import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/data/datasource/favorite_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class FavoriteDataSourceImpl implements FavoriteDataSource {
  final Box<CryptocurrencyModel> favoriteBox;

  FavoriteDataSourceImpl({required this.favoriteBox});

  @override
  Future<List<CryptocurrencyModel>> getFavorites() async {
    return favoriteBox.values.toList();
  }

  @override
  Future<void> saveFavorite(CryptocurrencyModel currency) async {
    await favoriteBox.put(currency.id, currency);
  }

  @override
  Future<void> deleteFavorite(int currencyId) async {
    await favoriteBox.delete(currencyId);
  }

  @override
  Future<bool> isFavorite(int currencyId) async {
    return favoriteBox.containsKey(currencyId);
  }
}
