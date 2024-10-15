import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

abstract class FavoriteLocalDataSource {
  Future<List<CryptocurrencyModel>> getFavorites();

  Future<void> saveFavorite(CryptocurrencyModel currency);

  Future<void> deleteFavorite(int currencyId);

  Future<bool> isFavorite(int currencyId);
}
