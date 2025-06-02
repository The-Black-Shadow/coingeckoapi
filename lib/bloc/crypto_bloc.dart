import 'package:bloc/bloc.dart';
import 'package:coingeckoapi/data/model/price_point.dart';
import 'package:coingeckoapi/data/repository/crypto_repository.dart';
import 'package:meta/meta.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository repository;

  CryptoBloc(this.repository) : super(CryptoInitial()) {
    on<LoadCryptoData>((event, emit) async {
      emit(CryptoLoading());
      try {
        await repository.fetchAllPrices();
        final data = repository.getCachedData(event.coinId);
        emit(CryptoLoaded(data));
      } catch (e) {
        emit(CryptoError(e.toString()));
      }
    });

    on<RefreshCryptoData>((event, emit) async {
      try {
        await repository.fetchAllPrices();
        final data = repository.getCachedData(event.coinId);
        emit(CryptoLoaded(data));
      } catch (e) {
        emit(CryptoError(e.toString()));
      }
    });
  }
}
