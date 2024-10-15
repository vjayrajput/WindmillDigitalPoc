import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class LoadFavoritesState extends Equatable {
  const LoadFavoritesState();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesInitial extends LoadFavoritesState {}

class LoadFavoritesLoading extends LoadFavoritesState {}

class LoadFavoritesLoaded extends LoadFavoritesState {
  final List<CryptocurrencyUiModel> favorites;

  const LoadFavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class LoadFavoritesError extends LoadFavoritesState {
  final String message;

  const LoadFavoritesError({required this.message});

  @override
  List<Object?> get props => [message];
}
