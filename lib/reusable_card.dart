import 'package:flutter/material.dart';

class ReusableCard extends StatefulWidget {
  const ReusableCard({
    super.key,
    required this.coinRate,
    required this.selectedCurrency,
    required this.coin,
  });

  final String coin;
  final String? coinRate;
  final String selectedCurrency;

  @override
  State<ReusableCard> createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Text(
          textAlign: TextAlign.center,
          '1 ${widget.coin} = ${widget.coinRate} ${widget.selectedCurrency}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
