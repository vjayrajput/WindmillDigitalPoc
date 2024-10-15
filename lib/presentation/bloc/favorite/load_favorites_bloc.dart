import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/errors/error_handler.dart';
import 'package:windmill_digital_poc/domain/entities/cryptocurrency_entity.dart';
import 'package:windmill_digital_poc/domain/usecases/load_favorites_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/watch_favorites_use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_state.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/cryptocurrency_ui_mapper.dart';

class LoadFavoritesBloc extends Bloc<LoadFavoritesEvent, LoadFavoritesState> {
  final LoadFavoritesUseCase loadFavoritesUseCase;
  final WatchFavoritesUseCase watchFavoritesUseCase;

  LoadFavoritesBloc({
    required this.loadFavoritesUseCase,
    required this.watchFavoritesUseCase,
  }) : super(LoadFavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<WatchFavorites>(_onWatchFavorites);
  }

  // Handle the LoadFavorites event
  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<LoadFavoritesState> emit) async {
    emit(LoadFavoritesLoading());
    try {
      final favorites = await loadFavoritesUseCase(NoParams());
      final cryptocurrencies = _mapEntitiesToUiModels(favorites);
      emit(LoadFavoritesLoaded(cryptocurrencies));
    } catch (error) {
      emit(_handleError(error));
    }
  }

  // Handle the WatchFavorites event
  Future<void> _onWatchFavorites(
      WatchFavorites event, Emitter<LoadFavoritesState> emit) async {
    final result = watchFavoritesUseCase(NoParams());
    await emit.forEach<List<CryptocurrencyEntity>>(
      result,
      onData: (favorites) {
        final cryptocurrencies = _mapEntitiesToUiModels(favorites);
        return LoadFavoritesLoaded(cryptocurrencies);
      },
      onError: (error, _) => _handleError(error),
    );
  }

  // Utility function to map entity list to UI models
  List<CryptocurrencyUiModel> _mapEntitiesToUiModels(
      List<CryptocurrencyEntity> entities) {
    return entities
        .map((entity) => CryptocurrencyUiMapper.toUiModel(entity))
        .toList();
  }

  // Handle errors in a centralized method
  LoadFavoritesError _handleError(dynamic error) {
    final errorMessage = ErrorHandler.handleHiveError(error);
    return LoadFavoritesError(message: errorMessage);
  }
}
