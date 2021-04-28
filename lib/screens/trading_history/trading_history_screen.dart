import 'package:flutter/material.dart';

import '../../models/chat/temp_class.dart';
import '../../widgets/history_prod_card.dart';

// ignore: use_key_in_widget_constructors
class TradingHistoryScreen extends StatefulWidget {
  static const routeName = '/tradinghistory';
  // ignore: diagnostic_describe_all_properties
  final UserDetail userDetail = userDetailTemp;
  @override
  _TradingHistoryScreenState createState() => _TradingHistoryScreenState();
}

class _TradingHistoryScreenState extends State<TradingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
      ),
      body: Container(
        color: const Color.fromARGB(2, 3, 4, 2),
        child: ListView.builder(
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.all(8),
            child: HistoryProductCard(
             
            ),
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
