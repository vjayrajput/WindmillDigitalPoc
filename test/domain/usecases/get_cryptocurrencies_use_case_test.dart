import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/domain/usecases/get_cryptocurrencies_use_case.dart';

import '../../mock_classes_creator.mocks.dart';
import '../../testing_data.dart';

void main() {
  late GetCryptocurrenciesUseCase getCryptocurrenciesUseCase;
  late MockCryptocurrencyRepository mockCryptocurrencyRepository;

  setUp(() {
    mockCryptocurrencyRepository = MockCryptocurrencyRepository();
    getCryptocurrenciesUseCase =
        GetCryptocurrenciesUseCase(mockCryptocurrencyRepository);
  });

  group('GetCryptocurrenciesUseCase', () {
    test(
        'should return a list of cryptocurrencies when repository fetch is successful',
        () async {
      // Arrange
      when(mockCryptocurrencyRepository.fetchCryptocurrencies(
              start: anyNamed('start'), limit: anyNamed('limit')))
          .thenAnswer((_) async => testCryptocurrenciesEntityList);

      // Act
      final result = await getCryptocurrenciesUseCase.call(start: 0, limit: 10);

      // Assert
      expect(result, testCryptocurrenciesEntityList);
      verify(mockCryptocurrencyRepository.fetchCryptocurrencies(
              start: 0, limit: 10))
          .called(1);
    });

    test(
        'should return an empty list when repository fetch returns an empty list',
        () async {
      // Arrange
      when(mockCryptocurrencyRepository.fetchCryptocurrencies(
              start: anyNamed('start'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);

      // Act
      final result = await getCryptocurrenciesUseCase.call(start: 0, limit: 10);

      // Assert
      expect(result, []);
      verify(mockCryptocurrencyRepository.fetchCryptocurrencies(
              start: 0, limit: 10))
          .called(1);
    });

    test('should throw an exception when repository fetch fails', () async {
      // Arrange
      when(mockCryptocurrencyRepository.fetchCryptocurrencies(
              start: anyNamed('start'), limit: anyNamed('limit')))
          .thenThrow(Exception('Failed to fetch cryptocurrencies'));

      // Act & Assert
      expect(
        () => getCryptocurrenciesUseCase.call(start: 0, limit: 10),
        throwsA(isA<Exception>()),
      );
      verify(mockCryptocurrencyRepository.fetchCryptocurrencies(
              start: 0, limit: 10))
          .called(1);
    });
  });
}
