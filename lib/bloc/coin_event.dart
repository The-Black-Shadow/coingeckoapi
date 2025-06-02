part of 'coin_bloc.dart';

@immutable
sealed class CoinEvent {}

class LoadCoins extends CoinEvent {
  final List<String> coinIds;

  LoadCoins(this.coinIds);
}
