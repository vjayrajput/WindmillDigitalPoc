import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class FavoriteCurrencyEvent extends Equatable {
  const FavoriteCurrencyEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoriteCurrencyEvent {}

class AddFavorite extends FavoriteCurrencyEvent {
  final CryptocurrencyUiModel currency;

  const AddFavorite(this.currency);

  @override
  List<Object?> get props => [currency];
}

class RemoveFavorite extends FavoriteCurrencyEvent {
  final int currencyId;

  const RemoveFavorite(this.currencyId);

  @override
  List<Object?> get props => [currencyId];
}

class CheckFavorite extends FavoriteCurrencyEvent {
  final int currencyId;

  const CheckFavorite(this.currencyId);

  @override
  List<Object?> get props => [currencyId];
}
