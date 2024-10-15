import 'package:hive_flutter/hive_flutter.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';

abstract class FavoriteRepository {
  Future<List<CryptocurrencyEntity>> loadFavorites();

  Future<void> addFavorite(CryptocurrencyEntity currency);

  Future<void> removeFavorite(int currencyId);

  Future<bool> isFavorite(int currencyId);

  Stream<List<CryptocurrencyEntity>> watchFavorites();
}
