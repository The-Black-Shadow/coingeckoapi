part of 'coin_bloc.dart';

@immutable
sealed class CoinEvent {}

class LoadCoin extends CoinEvent {
  final String coinId;

  LoadCoin(this.coinId);
}
