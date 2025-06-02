import 'package:coingeckoapi/bloc/crypto_bloc.dart';
import 'package:coingeckoapi/data/repository/crypto_repository.dart';
import 'package:coingeckoapi/presentation/crypto_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CryptoRepository(),
      child: BlocProvider(
        create: (context) => CryptoBloc(context.read<CryptoRepository>()),
        child: MaterialApp(
          title: 'CoinGecko API Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const CryptoScreen(),
        ),
      ),
    );
  }
}
