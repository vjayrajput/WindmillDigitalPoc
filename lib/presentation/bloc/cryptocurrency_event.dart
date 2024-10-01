import 'package:equatable/equatable.dart';

abstract class CryptocurrencyEvent extends Equatable {
  const CryptocurrencyEvent();

  @override
  List<Object?> get props => [];
}

class LoadCryptocurrencies extends CryptocurrencyEvent {
  final int page;
  final int limit;

  const LoadCryptocurrencies({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
