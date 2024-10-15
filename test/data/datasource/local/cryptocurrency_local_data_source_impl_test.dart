import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/data/datasource/local/cryptocurrency_local_data_source_impl.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

import '../../../mock_classes_creator.mocks.dart';
import '../../../testing_data.dart';

void main() {
  late CryptocurrencyLocalDataSourceImpl dataSource;
  late MockBox<CryptocurrencyModel> mockCryptocurrencyBox;

  setUp(() {
    mockCryptocurrencyBox = MockBox<CryptocurrencyModel>();
    dataSource = CryptocurrencyLocalDataSourceImpl(cryptocurrencyBox: mockCryptocurrencyBox);
  });

  final cryptocurrencyList = [
    testCryptocurrencyModel1,
    testCryptocurrencyModel2,
    testCryptocurrencyModel3,
  ];

  test('should return a list of cryptocurrencies from the local data source', () async {
    // Arrange
    when(mockCryptocurrencyBox.values).thenReturn(cryptocurrencyList);

    // Act
    final result = await dataSource.fetchCryptocurrencies(start: 1, limit: 2);

    // Assert
    expect(result, cryptocurrencyList.take(2).toList());
    verify(mockCryptocurrencyBox.values).called(1);
  });

  test('should return an empty list when the box is empty', () async {
    // Arrange
    when(mockCryptocurrencyBox.values).thenReturn([]);

    // Act
    final result = await dataSource.fetchCryptocurrencies(start: 1, limit: 10);

    // Assert
    expect(result, []);
    verify(mockCryptocurrencyBox.values).called(1);
  });

  test('should skip items based on the start parameter', () async {
    // Arrange
    when(mockCryptocurrencyBox.values).thenReturn(cryptocurrencyList);

    // Act
    final result = await dataSource.fetchCryptocurrencies(start: 2, limit: 2);

    // Assert
    expect(result, cryptocurrencyList.skip(1).take(2).toList());
    verify(mockCryptocurrencyBox.values).called(1);
  });
}
