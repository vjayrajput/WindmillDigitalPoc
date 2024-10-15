import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:windmill_digital_poc/core/util/connectivity_check.dart';
import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/service/api_service.dart';
import 'package:windmill_digital_poc/domain/repositories/cryptocurrency_repository.dart';
import 'package:windmill_digital_poc/domain/repositories/favorite_repository.dart';

@GenerateMocks([
  FavoriteRepository,
  CryptocurrencyRepository,
  Dio,
  Box<CryptocurrencyModel>,
  ApiService,
  ConnectivityCheck,
])
void main() {}
