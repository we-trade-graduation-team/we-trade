import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/widgets/trading_prod_card.dart';

import '../../../models/chat/temp_class.dart';
import '../../../widgets/review_card.dart';

class TradingProductsTab extends StatelessWidget {
  const TradingProductsTab({Key? key, required this.userDetail}) : super(key: key);

  final UserDetail userDetail;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // child: Text('hello'),
      child: ListView.builder(
        itemCount: userDetail.reviews!.length,
        itemBuilder: (context, index) => TradingProductCard(
          review: userDetail.reviews![index],
          //press: () {},
          // press: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => MessagesScreen(),
          //   ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}
