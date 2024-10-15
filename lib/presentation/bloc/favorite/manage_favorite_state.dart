import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class ManageFavoriteState extends Equatable {
  const ManageFavoriteState();

  @override
  List<Object?> get props => [];
}

class ManageFavoriteInitial extends ManageFavoriteState {}

class ManageFavoriteLoading extends ManageFavoriteState {}

class LoadedFavoriteStatus extends ManageFavoriteState {
  final CryptocurrencyUiModel currency;
  final bool isFavorite;

  const LoadedFavoriteStatus({
    required this.currency,
    this.isFavorite = false,
  });

  LoadedFavoriteStatus copyWith({
    CryptocurrencyUiModel? currency,
    bool? isFavorite = false,
  }) {
    return LoadedFavoriteStatus(
      currency: currency ?? this.currency,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [currency, isFavorite];
}

class ManageFavoriteError extends ManageFavoriteState {
  final String message;

  const ManageFavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}
