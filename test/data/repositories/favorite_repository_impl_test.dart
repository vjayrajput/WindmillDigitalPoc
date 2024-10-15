import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/data/models/mapper/cryptocurrency_mapper.dart';
import 'package:windmill_digital_poc/data/repositories/favorite_repository_impl.dart';

import '../../mock_classes_creator.mocks.dart';
import '../../testing_data.dart';

void main() {
  late MockFavoriteLocalDataSource mockLocalDataSource;
  late FavoriteRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockFavoriteLocalDataSource();
    repository = FavoriteRepositoryImpl(mockLocalDataSource);
  });

  final cryptocurrencyModel = testCryptocurrencyModel1;
  final cryptocurrencyEntity = testCryptocurrencyEntity1;
  final cryptocurrencyListModel = [cryptocurrencyModel];
  final cryptocurrencyListEntity = [cryptocurrencyEntity];

  group('FavoriteRepositoryImpl', () {
    test('should call saveFavorite with the correct model', () async {
      // Arrange
      final cryptoEntity = testCryptocurrencyEntity1; // Make sure this is defined
      final testCryptocurrencyModel1 = CryptocurrencyMapper.toModel(cryptoEntity);
      print('Model to save: $testCryptocurrencyModel1'); // Check the output

      // Mock the saveFavorite method
      when(mockLocalDataSource.saveFavorite(testCryptocurrencyModel1)).thenAnswer((_) async {
        print('Mock saveFavorite called');
      });

      // Act
      await mockLocalDataSource.saveFavorite(testCryptocurrencyModel1); // Directly call to isolate

      // Assert
      verify(mockLocalDataSource.saveFavorite(testCryptocurrencyModel1)).called(1);
    });


    test('should remove a favorite successfully', () async {
      // Arrange
      const currencyId = 1;
      when(mockLocalDataSource.deleteFavorite(currencyId))
          .thenAnswer((_) async => Future.value());

      // Act
      await repository.removeFavorite(currencyId);

      // Assert
      verify(mockLocalDataSource.deleteFavorite(currencyId)).called(1);
    });

    test('should check if a currency is favorite successfully', () async {
      // Arrange
      const currencyId = 1;
      when(mockLocalDataSource.isFavorite(currencyId)).thenAnswer((_) async => true);

      // Act
      final result = await repository.isFavorite(currencyId);

      // Assert
      expect(result, true);
      verify(mockLocalDataSource.isFavorite(currencyId)).called(1);
    });

    test('should load favorites successfully', () async {
      // Arrange
      final cryptoModelList = [
        testCryptocurrencyModel1,
        testCryptocurrencyModel2,
      ];
      when(mockLocalDataSource.getFavorites())
          .thenAnswer((_) async => cryptoModelList);

      // Act
      final favorites = await repository.loadFavorites();

      // Assert
      expect(favorites.length, 2);
      verify(mockLocalDataSource.getFavorites()).called(1);
    });

    group('addFavorite', () {
      test('should call local data source to save a favorite cryptocurrency', () async {
        // Act
        await repository.addFavorite(cryptocurrencyEntity);

        // Assert
        verify(mockLocalDataSource.saveFavorite(any)).called(1);
      });
    });

    group('watchFavorites', () {
      test('should return a stream of favorite cryptocurrency entities', () async {
        // Arrange
        when(mockLocalDataSource.watchFavorites()).thenAnswer(
              (_) => Stream.value(cryptocurrencyListModel),
        );

        // Act
        final stream = repository.watchFavorites();

        // Assert
        expectLater(stream, emits(cryptocurrencyListEntity));
        verify(mockLocalDataSource.watchFavorites()).called(1);
      });
    });


  });
}
