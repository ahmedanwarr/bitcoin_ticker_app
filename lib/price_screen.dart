import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'reusable_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String selectedCurrency = 'AUD';

  DropdownMenu<String> androidDropDown() {
    List<DropdownMenuEntry<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuEntry(value: currency, label: currency);
      dropdownItems.add(newItem);
    }

    return DropdownMenu<String>(
      initialSelection: selectedCurrency,
      dropdownMenuEntries: dropdownItems,
      onSelected: (value) {
        setState(() {
          selectedCurrency = value!;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> pickerItems = [];

    for (String currency in currenciesList) {
      var text = Text(currency);
      pickerItems.add(text);
    }

    return CupertinoPicker(
      backgroundColor: Colors.blue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          updateUI();
        });
      },
      looping: true,
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void updateUI() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            color: Colors.blue,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }

  Column makeCards() {
    List<ReusableCard> cards = [];
    for (String coin in cryptoList) {
      cards.add(
        ReusableCard(
            coin: coin,
            coinRate: isWaiting ? '?' : coinValues[coin],
            selectedCurrency: selectedCurrency),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    );
  }
}
