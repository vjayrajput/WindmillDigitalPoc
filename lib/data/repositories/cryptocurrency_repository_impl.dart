import 'package:windmill_digital_poc/data/datasource/cryptocurrency_data_source.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/models/mapper/cryptocurrency_mapper.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';

class CryptocurrencyRepositoryImpl implements CryptocurrencyRepository {
  final CryptocurrencyDataSource dataSource;

  CryptocurrencyRepositoryImpl(this.dataSource);

  @override
  Future<List<CryptocurrencyEntity>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    final List<CryptocurrencyModel> data =
        await dataSource.getCryptocurrencies(start: start, limit: limit);
    final List<CryptocurrencyEntity> cryptocurrencies = data.map((model) {
      return CryptocurrencyMapper.toEntity(model);
    }).toList();
    return cryptocurrencies;
  }
}
