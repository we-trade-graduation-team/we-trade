import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/configs/constants/color.dart';
import 'package:we_trade/widgets/buttons.dart';
import 'package:we_trade/widgets/product_card.dart';
import '../../models/product_model.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen(
      {Key? key,
      this.offerSideProducts,
      required this.forProduct,
      this.offerSideMoney,
      required this.isOfferSide})
      : super(key: key);

  final List<Product>? offerSideProducts;
  final int? offerSideMoney;
  final Product forProduct;
  final bool isOfferSide;

  @override
  Widget build(BuildContext context) {
    // String firstButtonStr, secondButtonStr;
    // VoidCallback firstButtonPress, secondButtonPress;
    // if(isOfferSide == true){
    //   firstButtonStr ='HỦY';
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('OFFER DETAIL'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MINE - các sản phẩm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            offerSideProducts!.length,
                            (index) {
                              return Row(
                                children: [
                                  ProductCard(
                                      product: offerSideProducts![index]),
                                  const SizedBox(width: 20),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'YOURS - sản phẩm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProductCard(product: forProduct),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Số tiền offer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          //color: Colors.red,
                          child: TextFormField(
                            enabled: false,
                            initialValue: offerSideMoney.toString(),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              hintStyle: TextStyle(height: 2),
                              labelText: '',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                if (isOfferSide ==
                    true) //nếu là người người chỉ có 1 nút bấm là thu hồi lại đề nghị
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ButtonWidget(
                          press: () {},
                          isFilled: false,
                          text: 'THU HỒI',
                          width: MediaQuery.of(context).size.width / 4,
                          fontsize: 15,
                          height: 40),
                    ),
                  ),
                //nếu là người được gửi đến sẽ có 2 nút bấm
                // từ chối đề nghị
                // chấp nhận đề nghị
                if (isOfferSide == false)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ButtonWidget(
                          press: () {},
                          isFilled: false,
                          text: 'TỪ CHỐI',
                          width: MediaQuery.of(context).size.width / 4,
                          fontsize: 15,
                          height: 40),
                    ),
                  ),
                if (isOfferSide == false)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ButtonWidget(
                          press: () {},
                          text: 'CHẤP NHẬN',
                          width: MediaQuery.of(context).size.width / 4,
                          fontsize: 15,
                          height: 40),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<Product>('offerSideProducts', offerSideProducts));
    properties.add(IntProperty('offerSideMoney', offerSideMoney));
    properties.add(DiagnosticsProperty<Product>('forProduct', forProduct));
  }
}
