# coingeckoapi

A Flutter app that displays real-time cryptocurrency prices using the CoinGecko API. Built with Bloc state management and clean architecture principles.

## Features

- Fetches and displays live prices for popular cryptocurrencies (Bitcoin, Ethereum, Binance Coin, Ripple, Solana)
- Shows price, symbol, name, and 24h price change with color indicators
- Pull-to-refresh for latest data
- Error handling for API/network issues
- Clean, modern UI with Flutter Material components
- Bloc pattern for scalable state management
- Easily extendable to support more coins

## Getting Started

1.Create a `.env` file in root directory

2. Add your CoinGecko API key to the `.env` file:
   ```
   COINGECKO_API_KEY=your_api_key_here
   ```
3. Run `flutter pub get` to install dependencies.
4. Start the app with `flutter run`.

## Dependencies

- flutter_bloc
- http
- flutter_dotenv
- bloc

## Folder Structure

- `lib/bloc/` - Bloc logic (events, states, bloc)
- `lib/data/` - Data models and repository
- `lib/presentation/` - UI screens
- `lib/app.dart` - App root
- `lib/main.dart` - Entry point

---

This project is for educational/demo purposes and uses the CoinGecko demo API key by default. For production, use your own API key.
