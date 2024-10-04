import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/domain/usecases/load_favorites_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';

import '../../mock_classes_creator.mocks.dart';
import '../../testing_data.dart';

void main() {
  late LoadFavoritesUseCase loadFavoritesUseCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    loadFavoritesUseCase = LoadFavoritesUseCase(mockFavoriteRepository);
  });

  group('LoadFavoritesUseCase', () {
    test(
        'should return a list of favorite cryptocurrencies when repository call is successful',
        () async {
      // Arrange
      when(mockFavoriteRepository.loadFavorites())
          .thenAnswer((_) async => testCryptocurrenciesEntityList);

      // Act
      final result = await loadFavoritesUseCase.call(NoParams());

      // Assert
      expect(result, testCryptocurrenciesEntityList);
      verify(mockFavoriteRepository.loadFavorites()).called(1);
    });

    test(
        'should return an empty list when no favorite cryptocurrencies are available',
        () async {
      // Arrange
      when(mockFavoriteRepository.loadFavorites()).thenAnswer((_) async => []);

      // Act
      final result = await loadFavoritesUseCase.call(NoParams());

      // Assert
      expect(result, []);
      verify(mockFavoriteRepository.loadFavorites()).called(1);
    });

    test('should throw an exception when repository fails to load favorites',
        () async {
      // Arrange
      when(mockFavoriteRepository.loadFavorites())
          .thenThrow(Exception('Failed to load favorites'));

      // Act & Assert
      expect(() => loadFavoritesUseCase.call(NoParams()),
          throwsA(isA<Exception>()));
      verify(mockFavoriteRepository.loadFavorites()).called(1);
    });
  });
}
