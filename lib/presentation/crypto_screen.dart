import 'package:coingeckoapi/bloc/coin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinListPage extends StatelessWidget {
  const CoinListPage({super.key});

  final List<String> coinIds = const [
    'bitcoin',
    'ethereum',
    'binancecoin',
    'ripple',
    'solana',
  ];

  Future<void> _refresh(BuildContext context) async {
    context.read<CoinBloc>().add(LoadCoins(coinIds));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crypto Prices")),
      body: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          if (state is CoinLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoinLoaded) {
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.coins.length,
                itemBuilder: (context, index) {
                  final coin = state.coins[index];
                  final priceChange = coin.priceChangePercentage24h;
                  final priceChangeColor =
                      priceChange >= 0 ? Colors.green : Colors.red;
                  return ListTile(
                    leading: Image.network(coin.image, width: 40),
                    title: Text('${coin.symbol.toUpperCase()} ${coin.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('\$${coin.currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16)),
                    trailing: Text(
                      '${priceChange >= 0 ? '+' : ''}${priceChange.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: priceChangeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
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
