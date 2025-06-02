import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/coin_model.dart';

class CoinRepository {
  static const _baseUrl = 'https://api.coingecko.com/api/v3';
  final String apiKey;

  CoinRepository({required this.apiKey});

  Future<Coin> fetchCoin(String coinId) async {
    final url = Uri.parse('$_baseUrl/coins/$coinId');

    final response = await http.get(
      url,
      headers: {
        'x-cg-demo-api-key': apiKey, // CoinGecko header key (replace with real header if different)
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Coin.fromJson(data);
    } else {
      throw Exception('Failed to load coin');
    }
  }
}
