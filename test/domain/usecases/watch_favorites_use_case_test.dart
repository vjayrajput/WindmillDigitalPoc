import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/watch_favorites_use_case.dart';

import '../../mock_classes_creator.mocks.dart';
import '../../testing_data.dart';

void main() {
  late WatchFavoritesUseCase useCase;
  late MockFavoriteRepository mockFavoriteRepository;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    useCase = WatchFavoritesUseCase(mockFavoriteRepository);
  });

  final cryptocurrencyList = [
    testCryptocurrencyEntity1,
    testCryptocurrencyEntity2,
  ];

  test('should return a stream of list of favorite cryptocurrencies from repository', () async {
    // Arrange
    when(mockFavoriteRepository.watchFavorites())
        .thenAnswer((_) => Stream.value(cryptocurrencyList));

    // Act
    final result = useCase(NoParams());

    // Assert
    expectLater(result, emitsInOrder([cryptocurrencyList]));
    verify(mockFavoriteRepository.watchFavorites()).called(1);
  });

  test('should emit an empty list when there are no favorites', () async {
    // Arrange
    when(mockFavoriteRepository.watchFavorites())
        .thenAnswer((_) => Stream.value([]));

    // Act
    final result = useCase(NoParams());

    // Assert
    expectLater(result, emitsInOrder([[]]));
    verify(mockFavoriteRepository.watchFavorites()).called(1);
  });
}
