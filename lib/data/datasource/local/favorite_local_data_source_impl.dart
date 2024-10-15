import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/data/datasource/favorite_local_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final Box<CryptocurrencyModel> favoriteBox;

  FavoriteLocalDataSourceImpl({required this.favoriteBox});

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

  @override
  Stream<List<CryptocurrencyModel>> watchFavorites() {
    return favoriteBox.watch().map((_) {
      return favoriteBox.values.toList();
    });
  }
}
