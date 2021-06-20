import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/ui/shared_models/product_model.dart';
import '../shared_widgets/geting_data_status.dart';
import '../shared_widgets/history_prod_card.dart';
import '../utils.dart';

class TradingHistoryScreen extends StatefulWidget {
  const TradingHistoryScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/tradinghistory';

  @override
  _TradingHistoryScreenState createState() => _TradingHistoryScreenState();
}

class _TradingHistoryScreenState extends State<TradingHistoryScreen> {
  final userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final referenceDatabase = FirebaseFirestore.instance;
    final offerSideProducts = [allProduct[0], allProduct[1]];
    const money = 100000;
    final forProduct = allProduct[3];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: referenceDatabase.collection('users').doc(userID).snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            showMyNotificationDialog(
                context: context,
                title: 'Lỗi',
                content: 'Tải dữ liệu không thành công. Vui lòng thử lại!',
                handleFunction: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final tradingHistory = data['tradingHistory'] as List;
          return Container(
            color: const Color.fromARGB(2, 3, 4, 2),
            child: tradingHistory.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return FutureBuilder<DocumentSnapshot>(
                        future: referenceDatabase
                            .collection('tradings')
                            .doc(tradingHistory[index].toString())
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const WentWrong();
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const DataDoesNotExist();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: HistoryProductCard(
                                key: Key(snapshot.data!.id.toString()),
                                tradingID: snapshot.data!.id,
                                offerSideProducts: offerSideProducts,
                                forProduct: forProduct,
                                offerSideMoney: money,
                              ),
                            );
                          }
                          return const CustomLinearProgressIndicator(
                              verticalPadding: 65, horizontalPadding: 30);
                        },
                      );
                    },
                    itemCount: tradingHistory.length,
                  )
                : const CenterNotificationWhenHaveNoRecord(
                    text: 'Bạn chưa thực hiện giao dịch nào'),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userID', userID));
  }
}
