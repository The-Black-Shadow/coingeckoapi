part of 'crypto_bloc.dart';

@immutable
sealed class CryptoEvent {}

class LoadCryptoData extends CryptoEvent {
  final String coinId;
  LoadCryptoData(this.coinId);
}

class RefreshCryptoData extends CryptoEvent {
  final String coinId;
  RefreshCryptoData(this.coinId);
}
