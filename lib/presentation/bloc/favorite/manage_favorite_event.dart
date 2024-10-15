import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class ManageFavoriteEvent extends Equatable {
  const ManageFavoriteEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoriteStatus extends ManageFavoriteEvent {
  final CryptocurrencyUiModel currency;

  const LoadFavoriteStatus({
    required this.currency,
  });

  @override
  List<Object?> get props => [currency];
}

class AddFavoriteEvent extends ManageFavoriteEvent {
  final CryptocurrencyUiModel currency;

  const AddFavoriteEvent(this.currency);

  @override
  List<Object?> get props => [currency];
}

class RemoveFavoriteEvent extends ManageFavoriteEvent {
  final CryptocurrencyUiModel currency;

  const RemoveFavoriteEvent(this.currency);

  @override
  List<Object?> get props => [currency];
}
