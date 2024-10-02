import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/errors/error_handler.dart';
import 'package:windmill_digital_poc/domain/usecases/get_cryptocurrencies_use_case.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/models/mapper/cryptocurrency_ui_mapper.dart';

class CryptocurrencyBloc
    extends Bloc<CryptocurrencyEvent, CryptocurrencyState> {
  final GetCryptocurrenciesUseCase getCryptocurrenciesUseCase;

  CryptocurrencyBloc(this.getCryptocurrenciesUseCase)
      : super(CryptocurrencyInitial()) {
    on<LoadCryptocurrencies>((event, emit) async {
      if (state is CryptocurrencyLoaded && event.page > 1) {
        emit((state as CryptocurrencyLoaded).copyWith(isLoadingMore: true));
      } else {
        emit(CryptocurrencyLoading());
      }
      try {
        final cryptocurrenciesEntities = await getCryptocurrenciesUseCase(
            start: event.page, limit: event.limit);
        final newCryptocurrencies = cryptocurrenciesEntities.map((entity) {
          return CryptocurrencyUiMapper.toUiModel(entity);
        }).toList();

        if (state is CryptocurrencyLoaded) {
          final currentCryptocurrencies =
              (state as CryptocurrencyLoaded).cryptocurrencies;
          emit(CryptocurrencyLoaded(
            cryptocurrencies: currentCryptocurrencies + newCryptocurrencies,
            isLoadingMore: false,
          ));
        } else {
          emit(CryptocurrencyLoaded(cryptocurrencies: newCryptocurrencies));
        }
      } catch (error) {
        print("cryptoBloc error 1 : ${error}");
        emit(CryptocurrencyError(message: ErrorHandler.handleError(error)));
      }
    });
  }
}
