import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/domain/usecases/add_favorite_use_case.dart';

import '../../mock_classes_creator.mocks.dart';
import '../../testing_data.dart';

void main() {
  late AddFavoriteUseCase addFavoriteUseCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    addFavoriteUseCase = AddFavoriteUseCase(mockFavoriteRepository);
  });

  group('AddFavoriteUseCase', () {
    test('should add the cryptocurrency to favorites', () async {
      // Arrange
      when(mockFavoriteRepository.addFavorite(any))
          .thenAnswer((_) async => Future.value());

      // Act
      await addFavoriteUseCase.call(testCryptocurrencyEntity1);

      // Assert
      verify(mockFavoriteRepository.addFavorite(testCryptocurrencyEntity1))
          .called(1);
    });

    test('should throw an exception when repository fails', () async {
      // Arrange
      when(mockFavoriteRepository.addFavorite(any))
          .thenThrow(Exception('Failed to add favorite'));

      // Act & Assert
      expect(() => addFavoriteUseCase.call(testCryptocurrencyEntity1),
          throwsA(isA<Exception>()));
      verify(mockFavoriteRepository.addFavorite(testCryptocurrencyEntity1))
          .called(1);
    });
  });
}
