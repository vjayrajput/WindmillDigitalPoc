import 'package:windmill_digital_poc/data/datasource/favorite_local_data_source.dart';
import 'package:windmill_digital_poc/data/models/mapper/cryptocurrency_mapper.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  FavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<List<CryptocurrencyEntity>> loadFavorites() async {
    final favorites = await localDataSource.getFavorites();
    return favorites
        .map((model) => CryptocurrencyMapper.toEntity(model))
        .toList();
  }

  @override
  Future<void> addFavorite(CryptocurrencyEntity currency) {
    return localDataSource.saveFavorite(CryptocurrencyMapper.toModel(currency));
  }

  @override
  Future<void> removeFavorite(int currencyId) {
    return localDataSource.deleteFavorite(currencyId);
  }

  @override
  Future<bool> isFavorite(int currencyId) {
    return localDataSource.isFavorite(currencyId);
  }

  Stream<List<CryptocurrencyEntity>> watchFavorites() {
    return localDataSource.watchFavorites().map((models) {
      return models
          .map((model) => CryptocurrencyMapper.toEntity(model))
          .toList();
    });
  }
}
