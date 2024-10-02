import 'package:equatable/equatable.dart';

abstract class CryptocurrencyEvent extends Equatable {
  const CryptocurrencyEvent();

  @override
  List<Object?> get props => [];
}

class LoadCryptocurrencies extends CryptocurrencyEvent {
  const LoadCryptocurrencies();

  @override
  List<Object?> get props => [];
}

class LoadMoreCryptocurrencies extends CryptocurrencyEvent {
  const LoadMoreCryptocurrencies();
}
