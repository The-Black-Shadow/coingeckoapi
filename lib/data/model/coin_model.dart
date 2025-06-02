class Coin {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      currentPrice:
          json['market_data']['current_price']['usd']?.toDouble() ?? 0.0,
    );
  }
}
