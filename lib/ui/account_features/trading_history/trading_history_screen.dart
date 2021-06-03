import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/history_prod_card.dart';

class TradingHistoryScreen extends StatelessWidget {
  const TradingHistoryScreen({
    Key? key,
  }) : super(key: key);

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
            child: HistoryProductCard(),
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
