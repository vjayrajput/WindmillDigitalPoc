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
  final bool isLoadingMore;

  const CryptocurrencyLoaded({
    required this.cryptocurrencies,
    this.isLoadingMore = false,
  });

  CryptocurrencyLoaded copyWith({
    List<CryptocurrencyUiModel>? cryptocurrencies,
    bool? isLoadingMore = false,
  }) {
    return CryptocurrencyLoaded(
      cryptocurrencies: cryptocurrencies ?? this.cryptocurrencies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [cryptocurrencies, isLoadingMore];
}

class CryptocurrencyError extends CryptocurrencyState {
  final String message;

  const CryptocurrencyError({required this.message});

  @override
  List<Object?> get props => [message];
}
