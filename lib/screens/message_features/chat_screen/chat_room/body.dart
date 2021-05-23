import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/shared_models/product_model.dart';
import '../../shared_widgets/offer_card.dart';
import '../widgets/input_chat.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    //check if have offer chưa trả lời
    //nếu có thì trả ra card_offer ghim đầu
    //ko thì thôi :v
    const isHaveOfferDeal = true;
    final offerSideProducts = [allProduct[0], allProduct[1]];
    const money = 100000;
    final forProduct = allProduct[3];

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: ChatInput(),
        ),
        if (isHaveOfferDeal)
          Align(
            alignment: Alignment.topCenter,
            child: OfferCard(
                offerSideProducts: offerSideProducts,
                forProduct: forProduct,
                offerSideMoney: money),
          ),
      ],
    );
  }
}
