import 'package:windmill_digital_poc/data/datasource/favorite_data_source.dart';
import 'package:windmill_digital_poc/data/models/mapper/cryptocurrency_mapper.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource dataSource;

  FavoriteRepositoryImpl(this.dataSource);

  @override
  Future<List<CryptocurrencyEntity>> loadFavorites() async {
    final favorites = await dataSource.getFavorites();
    return favorites
        .map((model) => CryptocurrencyMapper.toEntity(model))
        .toList();
  }

  @override
  Future<void> addFavorite(CryptocurrencyEntity currency) {
    return dataSource.saveFavorite(CryptocurrencyMapper.toModel(currency));
  }

  @override
  Future<void> removeFavorite(int currencyId) {
    return dataSource.deleteFavorite(currencyId);
  }

  @override
  Future<bool> isFavorite(int currencyId) {
    return dataSource.isFavorite(currencyId);
  }
}
