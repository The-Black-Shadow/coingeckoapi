part of 'crypto_bloc.dart';

@immutable
sealed class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<PricePoint> prices;
  CryptoLoaded(this.prices);
}

class CryptoError extends CryptoState {
  final String message;
  CryptoError(this.message);
}
