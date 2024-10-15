import 'package:equatable/equatable.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

abstract class LoadFavoritesEvent extends Equatable {
  const LoadFavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends LoadFavoritesEvent {}

class WatchFavorites extends LoadFavoritesEvent {}

