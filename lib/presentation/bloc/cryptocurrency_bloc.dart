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
      emit(CryptocurrencyLoading());
      try {
        final cryptocurrenciesEntities = await getCryptocurrenciesUseCase(
            start: event.page, limit: event.limit);
        final cryptocurrencies = cryptocurrenciesEntities.map((entity) {
          return CryptocurrencyUiMapper.toUiModel(entity);
        }).toList();
        emit(CryptocurrencyLoaded(cryptocurrencies));
      } catch (error) {
        emit(CryptocurrencyError(message: ErrorHandler.handleError(error)));
      }
    });
  }
}
