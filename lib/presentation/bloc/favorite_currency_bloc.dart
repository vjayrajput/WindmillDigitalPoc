import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/errors/error_handler.dart';
import 'package:windmill_digital_poc/domain/usecases/add_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/check_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/load_favorites_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/remove_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_state.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/cryptocurrency_ui_mapper.dart';

class FavoriteCurrencyBloc
    extends Bloc<FavoriteCurrencyEvent, FavoriteCurrencyState> {
  final LoadFavoritesUseCase loadFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final CheckFavoriteUseCase checkFavoriteUseCase;

  // Create a StreamController to listen for add/remove actions
  final StreamController<void> _favoritesController =
      StreamController.broadcast();

  FavoriteCurrencyBloc({
    required this.addFavoriteUseCase,
    required this.checkFavoriteUseCase,
    required this.loadFavoritesUseCase,
    required this.removeFavoriteUseCase,
  }) : super(FavoriteCurrencyInitial()) {
    // Subscribe to stream and trigger LoadFavorites on change
    _favoritesController.stream.listen((_) {
      add(LoadFavorites()); // Automatically reload favorites
    });

    on<LoadFavorites>((event, emit) async {
      emit(FavoriteCurrencyLoading());
      try {
        final favorites = await loadFavoritesUseCase(NoParams());
        final cryptocurrencies = favorites.map((entity) {
          return CryptocurrencyUiMapper.toUiModel(entity);
        }).toList();
        emit(FavoriteCurrencyLoaded(cryptocurrencies));
      } catch (error) {
        print("favoriteBloc error 1 : ${error}");
        // Handle Hive or other errors
        final errorMessage = ErrorHandler.handleHiveError(error);
        print("Error while loading favorites: $errorMessage");
        emit(FavoriteCurrencyError(errorMessage));
      }
    });

    on<AddFavorite>((event, emit) async {
      emit(FavoriteCurrencyLoading());
      try {
        await addFavoriteUseCase(
            CryptocurrencyUiMapper.toEntity(event.currency));
        emit(CurrencyIsFavorite());
        _favoritesController.add(null); // Notify stream that change occurred
      } catch (error) {
        print("favoriteBloc error 2 : ${error}");
        final errorMessage = ErrorHandler.handleHiveError(error);
        print("Error while adding favorite: $errorMessage");
        emit(FavoriteCurrencyError(errorMessage));
      }
    });

    on<RemoveFavorite>((event, emit) async {
      emit(FavoriteCurrencyLoading());
      try {
        await removeFavoriteUseCase(event.currencyId);
        emit(CurrencyIsNotFavorite());
        _favoritesController.add(null); // Notify stream that change occurred
      } catch (error) {
        print("favoriteBloc error 3 : ${error}");
        final errorMessage = ErrorHandler.handleHiveError(error);
        print("Error while removing favorite: $errorMessage");
        emit(FavoriteCurrencyError(errorMessage));
      }
    });

    on<CheckFavorite>((event, emit) async {
      emit(FavoriteCurrencyLoading());
      try {
        final isFavorite = await checkFavoriteUseCase(event.currencyId);
        print("favoriteBloc response 2 : ${isFavorite}");
        if (isFavorite) {
          emit(CurrencyIsFavorite());
        } else {
          emit(CurrencyIsNotFavorite());
        }
      } catch (error) {
        print("favoriteBloc error 4 : ${error}");
        final errorMessage = ErrorHandler.handleHiveError(error);
        print("Error while checking favorite: $errorMessage");
        emit(FavoriteCurrencyError(errorMessage));
      }
    });
  }

  // Dispose the StreamController when Bloc is closed
  @override
  Future<void> close() {
    _favoritesController.close();
    return super.close();
  }
}
