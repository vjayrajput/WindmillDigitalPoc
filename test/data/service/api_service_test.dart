import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';

import '../../mock_classes_creator.mocks.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  late ApiService apiService;
  late MockDio mockDio;
  late MockBox<CryptocurrencyModel> mockCryptocurrencyBox;

  setUp(() {
    mockDio = MockDio();
    mockCryptocurrencyBox = MockBox<CryptocurrencyModel>();
    apiService =
        ApiService(dio: mockDio, cryptocurrencyBox: mockCryptocurrencyBox);
  });

  group('ApiService fetchCryptocurrencies', () {
    const start = 1;
    const limit = 10;

    test('should fetch cryptocurrencies and save to Hive on success', () async {
      // Arrange
      final cryptoData = [
        {
          "id": 1,
          "name": "Bitcoin",
          "symbol": "BTC",
          "slug": "bitcoin",
          "is_active": 1,
          "rank": 1,
          "first_historical_data": "2010-07-17T00:00:00Z",
          "last_historical_data": "2024-10-04T00:00:00Z"
        }
      ];

      final responseData = {
        "status": {"error_code": 0},
        "data": cryptoData,
      };

      final mockResponse = Response(
        requestOptions: RequestOptions(path: 'cryptocurrency/map'),
        data: responseData,
        statusCode: 200,
      );

      when(mockDio.get(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result =
          await apiService.fetchCryptocurrencies(start: start, limit: limit);

      // Assert
      expect(result.length, 1);
      expect(result.first.name, 'Bitcoin');
      verify(mockCryptocurrencyBox.put(1, any))
          .called(1); // Verifying the data is saved to Hive
    });

    test('should throw an exception when the API call fails', () async {
      // Arrange
      final mockResponse = Response(
        requestOptions: RequestOptions(path: 'cryptocurrency/map'),
        data: {
          'status': {'error_code': 400}
        },
        statusCode: 400,
      );

      when(mockDio.get(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
          () async => await apiService.fetchCryptocurrencies(
              start: start, limit: limit),
          throwsA(isA<Exception>()));
    });

    test('should throw DioException on Dio error', () async {
      // Arrange
      when(mockDio.get(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: 'cryptocurrency/map')));

      // Act & Assert
      expect(
          () async => await apiService.fetchCryptocurrencies(
              start: start, limit: limit),
          throwsA(isA<DioException>()));
    });

    test('should return an empty list when API response data is empty',
        () async {
      // Arrange
      final responseData = {
        "status": {"error_code": 0},
        "data": [],
      };

      final mockResponse = Response(
        requestOptions: RequestOptions(path: 'cryptocurrency/map'),
        data: responseData,
        statusCode: 200,
      );

      when(mockDio.get(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result =
          await apiService.fetchCryptocurrencies(start: start, limit: limit);

      // Assert
      expect(result, isEmpty); // No data returned
      verifyNever(mockCryptocurrencyBox.put(any, any)); // No data saved to Hive
    });
  });
}
