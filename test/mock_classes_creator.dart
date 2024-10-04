import 'package:mockito/annotations.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';

@GenerateMocks([
  FavoriteRepository,
  CryptocurrencyRepository,
])
void main() {}
