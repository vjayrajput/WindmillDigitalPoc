import 'package:windmill_digital_poc/core/errors/error_handler.dart';
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
    try {
      final List<CryptocurrencyModel> data =
          await dataSource.getCryptocurrencies(start: start, limit: limit);
      return data.map((model) {
        return CryptocurrencyMapper.toEntity(model);
      }).toList();
    } catch (error) {
      print("repositoryImpl error 1 : ${error}");
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}
