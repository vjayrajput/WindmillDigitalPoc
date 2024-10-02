import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/errors/error_handler.dart';
import 'package:windmill_digital_poc/domain/usecases/get_cryptocurrencies_use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/cryptocurrency_ui_mapper.dart';

class CryptocurrencyBloc extends Bloc<CryptocurrencyEvent, CryptocurrencyState> {
  final GetCryptocurrenciesUseCase getCryptocurrenciesUseCase;
  int _start = 1;
  final int _limit = 20;

  CryptocurrencyBloc(this.getCryptocurrenciesUseCase)
      : super(CryptocurrencyInitial()) {
    on<LoadCryptocurrencies>((event, emit) async {
      await _loadCryptocurrencies(emit, resetStart: true);
    });

    on<LoadMoreCryptocurrencies>((event, emit) async {
      if (state is CryptocurrencyLoaded && !(state as CryptocurrencyLoaded).isLoadingMore) {
        _start += _limit;
        emit((state as CryptocurrencyLoaded).copyWith(isLoadingMore: true));
        await _loadCryptocurrencies(emit);
      }
    });
  }

  Future<void> _loadCryptocurrencies(Emitter<CryptocurrencyState> emit, {bool resetStart = false}) async {
    if (resetStart) {
      _start = 1;
      emit(CryptocurrencyLoading());
    }

    try {
      final cryptocurrenciesEntities = await getCryptocurrenciesUseCase(
          start: _start, limit: _limit);
      final newCryptocurrencies = cryptocurrenciesEntities.map((entity) {
        return CryptocurrencyUiMapper.toUiModel(entity);
      }).toList();

      if (state is CryptocurrencyLoaded) {
        final currentCryptocurrencies = (state as CryptocurrencyLoaded).cryptocurrencies;
        emit(CryptocurrencyLoaded(
          cryptocurrencies: currentCryptocurrencies + newCryptocurrencies,
          isLoadingMore: false,
        ));
      } else {
        emit(CryptocurrencyLoaded(cryptocurrencies: newCryptocurrencies));
      }
    } catch (error) {
      print("cryptoBloc error: $error");
      emit(CryptocurrencyError(message: ErrorHandler.handleError(error)));
    }
  }
}

