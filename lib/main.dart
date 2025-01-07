import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(const BitcoinTicker());

class BitcoinTicker extends StatelessWidget {
  const BitcoinTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
      ),
      home: PriceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
