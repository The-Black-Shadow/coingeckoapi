import 'package:coingeckoapi/bloc/coin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinPage extends StatelessWidget {
  const CoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coin Price')),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinInitial) {
            return const Center(child: Text('Please wait...'));
          } else if (state is CoinLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoinLoaded) {
            return Center(
              child: Text(
                '${state.coin.name} (${state.coin.symbol.toUpperCase()}): \$${state.coin.currentPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
            );
          } else if (state is CoinError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
