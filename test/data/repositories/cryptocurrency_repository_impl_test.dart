import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/data/repositories/cryptocurrency_repository_impl.dart';

import '../../mock_classes_creator.mocks.dart';
import '../../testing_data.dart';

void main() {
  late CryptocurrencyRepositoryImpl repository;
  late MockCryptocurrencyLocalDataSource mockLocalDataSource;
  late MockCryptocurrencyRemoteDataSource mockRemoteDataSource;
  late MockConnectivityCheck mockConnectivityCheck;

  setUp(() {
    mockLocalDataSource = MockCryptocurrencyLocalDataSource();
    mockRemoteDataSource = MockCryptocurrencyRemoteDataSource();
    mockConnectivityCheck = MockConnectivityCheck();
    repository = CryptocurrencyRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      connectivityCheck: mockConnectivityCheck,
    );
  });

  final cryptocurrencyModel = testCryptocurrencyModel1;
  final cryptocurrencyEntity = testCryptocurrencyEntity1;
  final cryptocurrencyListModel = [cryptocurrencyModel];
  final cryptocurrencyListEntity = [cryptocurrencyEntity];

  group('fetchCryptocurrencies', () {
    test('should fetch cryptocurrencies from remote data source when online', () async {
      // Arrange: When online, fetch from remote data source
      when(mockConnectivityCheck.checkConnectivity()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.fetchCryptocurrencies(start: 1, limit: 10))
          .thenAnswer((_) async => cryptocurrencyListModel);

      // Act
      final result = await repository.fetchCryptocurrencies(start: 1, limit: 10);

      // Assert
      expect(result, cryptocurrencyListEntity);
      verify(mockConnectivityCheck.checkConnectivity()).called(1);
      verify(mockRemoteDataSource.fetchCryptocurrencies(start: 1, limit: 10)).called(1);
      verifyNever(mockLocalDataSource.fetchCryptocurrencies(start: 1, limit: 10));
    });

    test('should fetch cryptocurrencies from local data source when offline', () async {
      // Arrange: When offline, fetch from local data source
      when(mockConnectivityCheck.checkConnectivity()).thenAnswer((_) async => false);
      when(mockLocalDataSource.fetchCryptocurrencies(start: 1, limit: 10))
          .thenAnswer((_) async => cryptocurrencyListModel);

      // Act
      final result = await repository.fetchCryptocurrencies(start: 1, limit: 10);

      // Assert
      expect(result, cryptocurrencyListEntity);
      verify(mockConnectivityCheck.checkConnectivity()).called(1);
      verifyNever(mockRemoteDataSource.fetchCryptocurrencies(start: 1, limit: 10));
      verify(mockLocalDataSource.fetchCryptocurrencies(start: 1, limit: 10)).called(1);
    });
  });
}
