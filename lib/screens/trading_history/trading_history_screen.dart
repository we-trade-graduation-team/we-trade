import 'package:flutter/material.dart';
import 'package:we_trade/models/chat/temp_class.dart';
import 'package:we_trade/widgets/history_prod_card.dart';
import 'package:we_trade/widgets/trading_prod_card.dart';

class TradingHistoryScreen extends StatefulWidget {
  static const routeName = '/tradinghistory';
  final UserDetail userDetail = userDetailTemp;
  @override
  _TradingHistoryScreenState createState() => _TradingHistoryScreenState();
}

class _TradingHistoryScreenState extends State<TradingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
      ),
      body: Container(
        color: Color.fromARGB(2, 3, 4, 2),
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: HistoryProductCard(
             
            ),
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
