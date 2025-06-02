import 'package:coingeckoapi/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  String apiKey = dotenv.env['COINGECKO_API_KEY'] ?? '';
  runApp(MyApp(apiKey: apiKey));
}
