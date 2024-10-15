import 'package:windmill_digital_poc/core/util/connectivity_check.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_local_data_source.dart';
import 'package:windmill_digital_poc/data/datasource/cryptocurrency_remote_data_source.dart';
import 'package:windmill_digital_poc/data/models/mapper/cryptocurrency_mapper.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';

class CryptocurrencyRepositoryImpl implements CryptocurrencyRepository {
  final CryptocurrencyLocalDataSource localDataSource;
  final CryptocurrencyRemoteDataSource remoteDataSource;
  final ConnectivityCheck connectivityCheck;

  CryptocurrencyRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.connectivityCheck});

  @override
  Future<List<CryptocurrencyEntity>> fetchCryptocurrencies(
      {required int start, required int limit}) async {
    final isOnline = await connectivityCheck.checkConnectivity();

    final data = isOnline
        ? await remoteDataSource.fetchCryptocurrencies(
            start: start, limit: limit)
        : await localDataSource.fetchCryptocurrencies(
            start: start, limit: limit);

    return data.map(CryptocurrencyMapper.toEntity).toList();
  }
}
