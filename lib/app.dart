import 'package:coingeckoapi/bloc/coin_bloc.dart';
import 'package:coingeckoapi/data/repository/coin_repository.dart';
import 'package:coingeckoapi/presentation/crypto_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final String apiKey;
  const MyApp({super.key, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    final repo = CoinRepository(apiKey: apiKey);

    return MaterialApp(
      home: BlocProvider(
        create: (_) => CoinBloc(repository: repo)
          ..add(
            LoadCoins([
              'bitcoin',
              'ethereum',
              'binancecoin',
              'ripple',
              'solana',
            ]),
          ),
        child: CoinListPage(),
      ),
    );
  }
}
