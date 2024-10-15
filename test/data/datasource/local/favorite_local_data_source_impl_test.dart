import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/data/datasource/local/favorite_local_data_source_impl.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';

import '../../../mock_classes_creator.mocks.dart';
import '../../../testing_data.dart';

void main() {
  late FavoriteLocalDataSourceImpl dataSource;
  late MockBox<CryptocurrencyModel> mockFavoriteBox;

  setUp(() {
    mockFavoriteBox = MockBox<CryptocurrencyModel>();
    dataSource = FavoriteLocalDataSourceImpl(favoriteBox: mockFavoriteBox);
  });

  final cryptocurrency = testCryptocurrencyModel1;

  final cryptocurrencyList = [
    testCryptocurrencyModel1,
    testCryptocurrencyModel2,
  ];

  test('should return a list of favorite cryptocurrencies', () async {
    // Arrange
    when(mockFavoriteBox.values).thenReturn(cryptocurrencyList);

    // Act
    final result = await dataSource.getFavorites();

    // Assert
    expect(result, cryptocurrencyList);
    verify(mockFavoriteBox.values).called(1);
  });

  test('should save a cryptocurrency to favorites', () async {
    // Act
    await dataSource.saveFavorite(cryptocurrency);

    // Assert
    verify(mockFavoriteBox.put(cryptocurrency.id, cryptocurrency)).called(1);
  });

  test('should delete a favorite cryptocurrency by ID', () async {
    // Act
    await dataSource.deleteFavorite(cryptocurrency.id);

    // Assert
    verify(mockFavoriteBox.delete(cryptocurrency.id)).called(1);
  });

  test('should return true if cryptocurrency is favorite', () async {
    // Arrange
    when(mockFavoriteBox.containsKey(cryptocurrency.id)).thenReturn(true);

    // Act
    final result = await dataSource.isFavorite(cryptocurrency.id);

    // Assert
    expect(result, true);
    verify(mockFavoriteBox.containsKey(cryptocurrency.id)).called(1);
  });

  test('should return false if cryptocurrency is not favorite', () async {
    // Arrange
    when(mockFavoriteBox.containsKey(cryptocurrency.id)).thenReturn(false);

    // Act
    final result = await dataSource.isFavorite(cryptocurrency.id);

    // Assert
    expect(result, false);
    verify(mockFavoriteBox.containsKey(cryptocurrency.id)).called(1);
  });

  test(
    'should watch favorites and return a stream of favorite cryptocurrencies',
        () async {
      // Arrange: Mock the BoxEvent and the `values` call
      when(mockFavoriteBox.watch()).thenAnswer(
            (_) => Stream.value(BoxEvent(cryptocurrency.id, cryptocurrency, false)),
      );

      // This will simulate that the favorite box has the list of favorite cryptocurrencies
      when(mockFavoriteBox.values).thenReturn(cryptocurrencyList);

      // Act
      final stream = dataSource.watchFavorites();

      // Assert: Expect the stream to emit the list of cryptocurrencies
      await expectLater(stream, emits(cryptocurrencyList));

      verify(mockFavoriteBox.watch()).called(1);
      verify(mockFavoriteBox.values).called(1); // Verify `values` is accessed
    },
  );
}
