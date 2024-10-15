import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:windmill_digital_poc/core/util/connectivity_check.dart';

import '../../mock_classes_creator.mocks.dart';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Ensure bindings are initialized

  group('ConnectivityCheck', () {
    late MockConnectivity mockConnectivity;
    late ConnectivityCheck connectivityCheck;

    setUp(() {
      mockConnectivity = MockConnectivity();
      connectivityCheck = ConnectivityCheck(connectivity: mockConnectivity);
    });

    test('returns true when connected to wifi', () async {
      // Mocking the behavior of checkConnectivity to return a list with wifi
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // Inject mockConnectivity to ConnectivityCheck if needed
      final result = await connectivityCheck.checkConnectivity();

      expect(result, true);
      verify(mockConnectivity.checkConnectivity()).called(1);
    });

    test('returns true when connected to mobile data', () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.mobile]);

      final result = await connectivityCheck.checkConnectivity();

      expect(result, true);
      verify(mockConnectivity.checkConnectivity()).called(1);
    });

    test('returns true when connected to vpn', () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.vpn]);

      final result = await connectivityCheck.checkConnectivity();

      expect(result, true);
      verify(mockConnectivity.checkConnectivity()).called(1);
    });

    test('returns false when no connection is available', () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await connectivityCheck.checkConnectivity();

      expect(result, false);
      verify(mockConnectivity.checkConnectivity()).called(1);
    });
  });
}
