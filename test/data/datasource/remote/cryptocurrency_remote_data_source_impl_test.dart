import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/data/datasource/remote/cryptocurrency_remote_data_source_impl.dart';

import '../../../mock_classes_creator.mocks.dart';
import '../../../testing_data.dart';

void main() {
  late CryptocurrencyRemoteDataSourceImpl dataSource;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    dataSource = CryptocurrencyRemoteDataSourceImpl(apiService: mockApiService);
  });

  final cryptocurrencyList = [
    testCryptocurrencyModel1,
    testCryptocurrencyModel2,
  ];

  test('should return a list of cryptocurrencies when the call to API service is successful', () async {
    // Arrange
    when(mockApiService.fetchCryptocurrencies(start: 0, limit: 10))
        .thenAnswer((_) async => cryptocurrencyList);

    // Act
    final result = await dataSource.fetchCryptocurrencies(start: 0, limit: 10);

    // Assert
    expect(result, cryptocurrencyList);
    verify(mockApiService.fetchCryptocurrencies(start: 0, limit: 10)).called(1);
  });

  test('should throw an exception when the call to API service fails', () async {
    // Arrange
    when(mockApiService.fetchCryptocurrencies(start: 0, limit: 10))
        .thenThrow(Exception('Failed to fetch cryptocurrencies'));

    // Act
    final call = dataSource.fetchCryptocurrencies;

    // Assert
    expect(() => call(start: 0, limit: 10), throwsA(isA<Exception>()));
    verify(mockApiService.fetchCryptocurrencies(start: 0, limit: 10)).called(1);
  });
}
