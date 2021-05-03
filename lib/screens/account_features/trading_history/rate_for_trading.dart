import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';
import '../../../models/product/temp_class.dart';
import '../shared_widgets/rating_bar.dart';


class RateForTrading extends StatefulWidget {
  const RateForTrading({
    Key? key,
  }) : super(key: key);

  static const routeName = '/ratefortrading';

  @override
  _RateForTradingState createState() => _RateForTradingState();
}

class _RateForTradingState extends State<RateForTrading> {
  late int _rating;

  List<Widget> _buildProductsList(List<Product> products) {
    final widget = <Widget>[];
    for (var i = 0; i < products.length; i++) {
      widget.add(
        Row(
          children: [
            Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  products[i].images[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Text(
                products[i].name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
      widget.add(const SizedBox(height: 10));
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final products = [
      // {'name': 'Product 1', 'img': ''},
      // {'name': 'Product 2', 'img': ''},
      productsData[0], productsData[1],
    ];

    const titleWidth = 100.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá giao dịch'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text('Gửi'),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: kTextLightV2Color,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: titleWidth,
                        child: const Text(
                          'Người dùng',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              'assets/images/Chat_screen_ava_temp/user.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Duy Quang',
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: kTextLightV2Color,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: titleWidth,
                        child: const Text(
                          'Sản phẩm',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ..._buildProductsList(products),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kTextLightV2Color,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: titleWidth,
                        child: const Text(
                          'Số sao',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // const SizedBox(width: 10),
                      RatingBar(
                        onRatingSelected: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                          // ignore: avoid_print
                          print('rating $_rating');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kTextLightV2Color,
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        width: titleWidth,
                        child: const Text(
                          'Nhận xét',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const TextField(
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: 'Nhận xét giao dịch',
                          hintText: 'Nhập lời nhận xét...',
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
