import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/errors/error_handler.dart';
import 'package:windmill_digital_poc/domain/usecases/add_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/check_favorite_use_case.dart';
import 'package:windmill_digital_poc/domain/usecases/remove_favorite_use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_state.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/cryptocurrency_ui_mapper.dart';

class ManageFavoriteBloc
    extends Bloc<ManageFavoriteEvent, ManageFavoriteState> {
  final CheckFavoriteUseCase checkFavoriteUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;

  ManageFavoriteBloc({
    required this.checkFavoriteUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
  }) : super(ManageFavoriteInitial()) {
    on<LoadFavoriteStatus>((event, emit) async {
      try {
        final isFavorite = await checkFavoriteUseCase(event.currency.id);
        print("LoadFavoriteStatus c1");
        print("LoadFavoriteStatus isFavorite : $isFavorite");
        emit(LoadedFavoriteStatus(
            currency: event.currency, isFavorite: isFavorite));
      } catch (error) {
        final errorMessage = ErrorHandler.handleHiveError(error);
        emit(ManageFavoriteError(errorMessage));
      }
    });

    on<AddFavoriteEvent>((event, emit) async {
      try {
        print("AddFavoriteEvent c1");
        await addFavoriteUseCase(
            CryptocurrencyUiMapper.toEntity(event.currency));

        if (state is LoadedFavoriteStatus) {
          print("AddFavoriteEvent c2");
          emit((state as LoadedFavoriteStatus).copyWith(isFavorite: true));
        } else {
          print("AddFavoriteEvent c3");
          emit(
              LoadedFavoriteStatus(currency: event.currency, isFavorite: true));
        }
      } catch (error) {
        final errorMessage = ErrorHandler.handleHiveError(error);
        emit(ManageFavoriteError(errorMessage));
      }
    });

    on<RemoveFavoriteEvent>((event, emit) async {
      try {
        print("RemoveFavoriteEvent c1");
        await removeFavoriteUseCase(event.currency.id);
        if (state is LoadedFavoriteStatus) {
          print("RemoveFavoriteEvent c2");
          emit((state as LoadedFavoriteStatus).copyWith(isFavorite: false));
        } else {
          print("RemoveFavoriteEvent c3");
          emit(LoadedFavoriteStatus(
              currency: event.currency, isFavorite: false));
        }
      } catch (error) {
        final errorMessage = ErrorHandler.handleHiveError(error);
        emit(ManageFavoriteError(errorMessage));
      }
    });
  }
}
