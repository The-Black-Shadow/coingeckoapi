import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/coin_model.dart';

class CoinRepository {
  final String apiKey;

  CoinRepository({required this.apiKey});

  Future<List<Coin>> fetchCoins(List<String> ids) async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=${ids.join(",")}',
    );

    final response = await http.get(
      url,
      headers: {'x-cg-demo-api-key': apiKey},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      debugPrint('Fetched coins: $data');
      return data.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}
