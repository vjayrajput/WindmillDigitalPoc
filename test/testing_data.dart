import 'package:windmill_digital_poc/data/models/cryptocurrency_model.dart';
import 'package:windmill_digital_poc/data/models/platform_model.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/entities/platform_entity.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/models/platform_ui_model.dart';

var testPlatformModel1 = PlatformModel(
  id: 1,
  name: 'Ethereum',
  symbol: 'ETH',
  slug: 'ethereum',
  tokenAddress: '0x1234567890abcdef',
);

var testPlatformModel2 = PlatformModel(
  id: 2,
  name: 'Bitcoin',
  symbol: 'BTC',
  slug: 'bitcoin',
  tokenAddress: '0xabcdef1234567890',
);

var testCryptocurrencyModel1 = CryptocurrencyModel(
  id: 1,
  rank: 5,
  name: 'Bitcoin',
  symbol: "BTC",
  slug: "bitcoin",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformModel1,
);

var testCryptocurrencyModel2 = CryptocurrencyModel(
  id: 2,
  rank: 6,
  name: 'Ethereum',
  symbol: "USDT",
  slug: "ethereum",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformModel2,
);

var testCryptocurrencyModel3 = CryptocurrencyModel(
  id: 3,
  rank: 7,
  name: 'Novacoin',
  symbol: "NVC",
  slug: "novacoin",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformModel2,
);

const testPlatformEntity1 = PlatformEntity(
  id: 1,
  name: 'Ethereum',
  symbol: 'ETH',
  slug: 'ethereum',
  tokenAddress: '0x1234567890abcdef',
);

const testPlatformEntity2 = PlatformEntity(
  id: 2,
  name: 'Bitcoin',
  symbol: 'BTC',
  slug: 'bitcoin',
  tokenAddress: '0xabcdef1234567890',
);

const testCryptocurrencyEntity1 = CryptocurrencyEntity(
  id: 1,
  rank: 5,
  name: 'Bitcoin',
  symbol: "BTC",
  slug: "bitcoin",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformEntity1,
);

const testCryptocurrencyEntity2 = CryptocurrencyEntity(
  id: 2,
  rank: 6,
  name: 'Ethereum',
  symbol: "USDT",
  slug: "ethereum",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformEntity2,
);

const testPlatformUiModel1 = PlatformUiModel(
  id: 1,
  name: 'Ethereum',
  symbol: 'ETH',
  slug: 'ethereum',
  tokenAddress: '0x1234567890abcdef',
);

const testPlatformUiModel2 = PlatformUiModel(
  id: 2,
  name: 'Bitcoin',
  symbol: 'BTC',
  slug: 'bitcoin',
  tokenAddress: '0xabcdef1234567890',
);

const testCryptocurrencyUiModel1 = CryptocurrencyUiModel(
  id: 1,
  rank: 5,
  name: 'Bitcoin',
  symbol: "BTC",
  slug: "bitcoin",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformUiModel1,
);

const testCryptocurrencyUiModel2 = CryptocurrencyUiModel(
  id: 2,
  rank: 6,
  name: 'Ethereum',
  symbol: "USDT",
  slug: "ethereum",
  isActive: 1,
  firstHistoricalData: "2015-02-25T13:34:26.000Z",
  lastHistoricalData: "2020-05-05T20:44:01.000Z",
  platform: testPlatformUiModel2,
);

final testCryptocurrenciesModelList = [
  testCryptocurrencyModel1,
  testCryptocurrencyModel2,
];

final testCryptocurrenciesEntityList = [
  testCryptocurrencyEntity1,
  testCryptocurrencyEntity2,
];

final testCryptocurrenciesUiModelList = [
  testCryptocurrencyUiModel1,
  testCryptocurrencyUiModel2,
];
