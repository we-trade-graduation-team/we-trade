import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

import '../../../models/shared_models/product_model.dart';
import '../../../widgets/custom_material_button.dart';
import '../../../widgets/product_card.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  static String routeName = '/detail_offer';

  @override
  Widget build(BuildContext context) {
    final agrs = ModalRoute.of(context)!.settings.arguments
        as OfferDetailScreenArguments;
    const bottomMargin = 0.5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OFFER DETAIL'),
      ),
      body: Container(
        color: kScreenBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OfferDetailContainerContain(
                      childWidget: Text(
                        'YOURS - sản phẩm',
                        style: TextStyle(
                          fontSize: 16,
                          //color: kPrimaryColor,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      bottomMargin: bottomMargin,
                    ),
                    OfferDetailContainerContain(
                      childWidget: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              agrs.offerSideProducts!.length,
                              (index) {
                                return Row(
                                  children: [
                                    ProductCard(
                                        product:
                                            agrs.offerSideProducts![index]),
                                    const SizedBox(width: 20),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      bottomMargin: 5,
                    ),
                    const SizedBox(height: 20),
                    const OfferDetailContainerContain(
                      childWidget: Text(
                        'Số tiền offer',
                        style: TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      bottomMargin: bottomMargin,
                    ),
                    OfferDetailContainerContain(
                      childWidget: Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: agrs.offerSideMoney.toString(),
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
                      bottomMargin: 3,
                    ),
                    const SizedBox(height: 20),
                    const OfferDetailContainerContain(
                      childWidget: Text(
                        'YOURS - sản phẩm',
                        style: TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      bottomMargin: bottomMargin,
                    ),
                    OfferDetailContainerContain(
                      childWidget: Row(
                        children: [
                          ProductCard(product: agrs.forProduct),
                        ],
                      ),
                      bottomMargin: bottomMargin,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: kScreenBackgroundColor,
                child: Row(
                  children: [
                    if (agrs.isOfferSide ==
                        true) //nếu là người người chỉ có 1 nút bấm là thu hồi lại đề nghị
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomMaterialButton(
                              press: () {},
                              isFilled: false,
                              text: 'THU HỒI',
                              width: MediaQuery.of(context).size.width / 4,
                              fontSize: 15,
                              height: 40),
                        ),
                      ),
                    //nếu là người được gửi đến sẽ có 2 nút bấm
                    // từ chối đề nghị
                    // chấp nhận đề nghị
                    if (agrs.isOfferSide == false)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomMaterialButton(
                              press: () {},
                              isFilled: false,
                              text: 'TỪ CHỐI',
                              width: MediaQuery.of(context).size.width / 4,
                              fontSize: 15,
                              height: 40),
                        ),
                      ),
                    if (agrs.isOfferSide == false)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomMaterialButton(
                              press: () {},
                              text: 'CHẤP NHẬN',
                              width: MediaQuery.of(context).size.width / 4,
                              fontSize: 15,
                              height: 40),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfferDetailContainerContain extends StatelessWidget {
  const OfferDetailContainerContain({
    Key? key,
    required this.childWidget,
    required this.bottomMargin,
  }) : super(key: key);

  final Widget childWidget;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(0, 5, 0, bottomMargin),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: childWidget,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('bottomMargin', bottomMargin));
  }
}

class OfferDetailScreenArguments {
  OfferDetailScreenArguments(
      {this.offerSideProducts,
      required this.forProduct,
      this.offerSideMoney,
      required this.isOfferSide});

  final List<Product>? offerSideProducts;
  final int? offerSideMoney;
  final Product forProduct;
  final bool isOfferSide;
}
