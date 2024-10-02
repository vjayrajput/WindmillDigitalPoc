import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class FavoriteCurrencyState extends Equatable {
  const FavoriteCurrencyState();

  @override
  List<Object?> get props => [];
}

class FavoriteCurrencyInitial extends FavoriteCurrencyState {}

class FavoriteCurrencyLoading extends FavoriteCurrencyState {}

class FavoriteCurrencyLoaded extends FavoriteCurrencyState {
  final List<CryptocurrencyUiModel> favorites;

  const FavoriteCurrencyLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoriteCurrencyError extends FavoriteCurrencyState {
  final String message;

  const FavoriteCurrencyError(this.message);

  @override
  List<Object?> get props => [message];
}

class CurrencyIsFavorite extends FavoriteCurrencyState {}

class CurrencyIsNotFavorite extends FavoriteCurrencyState {}
