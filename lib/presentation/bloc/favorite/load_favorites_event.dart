import 'package:equatable/equatable.dart';

abstract class LoadFavoritesEvent extends Equatable {
  const LoadFavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends LoadFavoritesEvent {}

class WatchFavorites extends LoadFavoritesEvent {}

