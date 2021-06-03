import 'package:flutter/material.dart';

import '../../../constants/app_dimens.dart';
import '../../../models/ui/product/temp_class.dart';
import '../shared_widgets/rating_bar.dart';

class RateForTrading extends StatelessWidget {
  const RateForTrading({
    Key? key,
  }) : super(key: key);

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
                // ? Should be delete?
                // style: ElevatedButton.styleFrom(
                //   primary: Theme.of(context).primaryColor,
                // ),
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
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      bottom: AppDimens.kBorderSide(),
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
                              'assets/images/chat_screen_ava/user.png',
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
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      bottom: AppDimens.kBorderSide(),
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
                      const SizedBox(height: 10),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: AppDimens.kBorderSide(),
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
                        onRatingSelected: (rating) {},
                        // onRatingSelected: (rating) {
                        //   setState(() {
                        //     _rating = rating;
                        //   });
                        //   // print('rating $_rating');
                        // },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: AppDimens.kBorderSide(),
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

  List<Widget> _buildProductsList(List<Product> products) {
    return products.map((product) {
      return Row(
        children: [
          Container(
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.images[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
