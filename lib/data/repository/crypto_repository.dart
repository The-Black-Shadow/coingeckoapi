import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/price_point.dart';

class CryptoRepository {
  final List<String> _coins = [
    'bitcoin',
    'ethereum',
    'tether',
    'binancecoin',
    'solana',
    'usd-coin',
    'xrp',
    'dogecoin',
    'cardano',
    'avalanche',
  ];

  final Map<String, List<PricePoint>> _cache = {};

  List<String> get coins => _coins;

  Future<void> fetchAllPrices() async {
    final urls = _coins.map(
      (coin) =>
          'https://api.coingecko.com/api/v3/coins/$coin/market_chart?vs_currency=usd&days=7',
    );

    final responses = await Future.wait(
      urls.map((url) => http.get(Uri.parse(url))),
    );

    for (int i = 0; i < responses.length; i++) {
      if (responses[i].statusCode == 200) {
        final data = json.decode(responses[i].body);
        final prices = data['prices'] as List;
        _cache[_coins[i]] = prices.map((e) {
          final timestamp = e[0];
          final price = e[1];
          return PricePoint(
            time: timestamp.toDouble(),
            price: price.toDouble(),
          );
        }).toList();
      }
    }
  }

  List<PricePoint> getCachedData(String coinId) {
    return _cache[coinId] ?? [];
  }
}
