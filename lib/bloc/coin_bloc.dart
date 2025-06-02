import 'package:bloc/bloc.dart';
import 'package:coingeckoapi/data/model/coin_model.dart';
import 'package:coingeckoapi/data/repository/coin_repository.dart';
import 'package:meta/meta.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepository repository;

  CoinBloc({required this.repository}) : super(CoinInitial()) {
    on<LoadCoin>((event, emit) async {
      emit(CoinLoading());
      try {
        final coin = await repository.fetchCoin(event.coinId);
        emit(CoinLoaded(coin));
      } catch (e) {
        emit(CoinError('Failed to fetch coin: ${e.toString()}'));
      }
    });
  }
}
