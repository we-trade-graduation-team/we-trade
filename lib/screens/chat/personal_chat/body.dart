import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/models/product_model.dart';
import 'package:we_trade/widgets/offer_card.dart';
import '../../../configs/constants/color.dart';

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
    var offerSideProducts = [allProduct[0], allProduct[1]];
    var money = 100000;
    var forProduct = allProduct[3];

    return Stack(
      children: [
        const Align(
          alignment: Alignment.bottomLeft,
          child: ChatInput(),
        ),
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

class ChatInput extends StatelessWidget {
  const ChatInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const height = 48.0;

    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  child: const Icon(
                    Icons.menu,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  child: const Icon(
                    Icons.tag_faces_rounded,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 14 * 6 + 20),
              decoration: BoxDecoration(
                color: kBackGroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Flexible(
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Write message...',
                    hintStyle: TextStyle(color: Colors.black54),
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 35,
                  child: const Icon(
                    Icons.send_rounded,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
