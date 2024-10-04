import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/domain/usecases/remove_favorite_use_case.dart';

import '../../mock_classes_creator.mocks.dart';

void main() {
  late RemoveFavoriteUseCase removeFavoriteUseCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    removeFavoriteUseCase = RemoveFavoriteUseCase(mockFavoriteRepository);
  });

  const int testCurrencyId = 1;

  group('RemoveFavoriteUseCase', () {
    test(
        'should remove a favorite cryptocurrency when repository call is successful',
        () async {
      // Arrange
      when(mockFavoriteRepository.removeFavorite(testCurrencyId))
          .thenAnswer((_) async => Future.value());

      // Act
      await removeFavoriteUseCase.call(testCurrencyId);

      // Assert
      verify(mockFavoriteRepository.removeFavorite(testCurrencyId)).called(1);
    });

    test('should throw an exception when repository fails to remove a favorite',
        () async {
      // Arrange
      when(mockFavoriteRepository.removeFavorite(testCurrencyId))
          .thenThrow(Exception('Failed to remove favorite'));

      // Act & Assert
      expect(() => removeFavoriteUseCase.call(testCurrencyId),
          throwsA(isA<Exception>()));
      verify(mockFavoriteRepository.removeFavorite(testCurrencyId)).called(1);
    });
  });
}
