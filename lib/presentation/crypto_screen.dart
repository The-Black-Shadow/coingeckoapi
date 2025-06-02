import 'package:coingeckoapi/data/repository/crypto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/crypto_bloc.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  late final List<String> coins;
  String selectedCoin = 'bitcoin';

  @override
  void initState() {
    super.initState();
    final repo = context.read<CryptoRepository>();
    coins = repo.coins;
    context.read<CryptoBloc>().add(LoadCryptoData(selectedCoin));
  }

  void _onSelect(String coin) {
    setState(() => selectedCoin = coin);
    final bloc = context.read<CryptoBloc>();
    final data = context.read<CryptoRepository>().getCachedData(coin);
    if (data.isNotEmpty) {
      bloc.emit(CryptoLoaded(data));
    } else {
      bloc.add(LoadCryptoData(coin));
    }
  }

  Future<void> _onRefresh() async {
    context.read<CryptoBloc>().add(RefreshCryptoData(selectedCoin));
  }

  @override
  Widget build(BuildContext context) {
    final double chartHeight = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Viewer')),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SizedBox(
          height: chartHeight,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                color: Colors.grey[200],
                child: ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (context, index) {
                    final coin = coins[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 6,
                      ),
                      child: ElevatedButton(
                        onPressed: () => _onSelect(coin),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: coin == selectedCoin
                              ? Colors.blue
                              : Colors.white,
                          foregroundColor: coin == selectedCoin
                              ? Colors.white
                              : Colors.black,
                        ),
                        child: Text(coin.toUpperCase()),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<CryptoBloc, CryptoState>(
                  builder: (context, state) {
                    if (state is CryptoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CryptoLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: state.prices
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => FlSpot(
                                        e.key.toDouble(),
                                        e.value.price,
                                      ),
                                    )
                                    .toList(),
                                isCurved: true,
                                color: Colors.blue,
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                dotData: FlDotData(show: false),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is CryptoError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
