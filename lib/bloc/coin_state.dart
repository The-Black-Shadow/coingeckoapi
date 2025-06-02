part of 'coin_bloc.dart';

@immutable
sealed class CoinState {}

final class CoinInitial extends CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final Coin coin;

  CoinLoaded(this.coin);
}

class CoinError extends CoinState {
  final String message;

  CoinError(this.message);
}
