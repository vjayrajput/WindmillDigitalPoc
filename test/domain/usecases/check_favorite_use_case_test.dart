import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/domain/usecases/check_favorite_use_case.dart';

import '../../mock_classes_creator.mocks.dart';

void main() {
  late CheckFavoriteUseCase checkFavoriteUseCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    checkFavoriteUseCase = CheckFavoriteUseCase(mockFavoriteRepository);
  });

  const currencyId = 1;

  group('CheckFavoriteUseCase', () {
    test('should return true if the cryptocurrency is in favorites', () async {
      // Arrange
      when(mockFavoriteRepository.isFavorite(currencyId))
          .thenAnswer((_) async => true);

      // Act
      final result = await checkFavoriteUseCase.call(currencyId);

      // Assert
      expect(result, true);
      verify(mockFavoriteRepository.isFavorite(currencyId)).called(1);
    });

    test('should return false if the cryptocurrency is not in favorites',
        () async {
      // Arrange
      when(mockFavoriteRepository.isFavorite(currencyId))
          .thenAnswer((_) async => false);

      // Act
      final result = await checkFavoriteUseCase.call(currencyId);

      // Assert
      expect(result, false);
      verify(mockFavoriteRepository.isFavorite(currencyId)).called(1);
    });

    test('should throw an exception when repository fails', () async {
      // Arrange
      when(mockFavoriteRepository.isFavorite(currencyId))
          .thenThrow(Exception('Failed to check favorite'));

      // Act & Assert
      expect(() => checkFavoriteUseCase.call(currencyId),
          throwsA(isA<Exception>()));
      verify(mockFavoriteRepository.isFavorite(currencyId)).called(1);
    });
  });
}
