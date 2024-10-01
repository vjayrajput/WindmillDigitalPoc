import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class CryptocurrencyState extends Equatable {
  const CryptocurrencyState();

  @override
  List<Object?> get props => [];
}

class CryptocurrencyInitial extends CryptocurrencyState {}

class CryptocurrencyLoading extends CryptocurrencyState {}

class CryptocurrencyLoaded extends CryptocurrencyState {
  final List<CryptocurrencyUiModel> cryptocurrencies;

  const CryptocurrencyLoaded(this.cryptocurrencies);

  @override
  List<Object?> get props => [cryptocurrencies];
}

class CryptocurrencyError extends CryptocurrencyState {
  final String message;

  const CryptocurrencyError({required this.message});

  @override
  List<Object?> get props => [message];
}
