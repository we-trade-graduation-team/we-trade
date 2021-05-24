import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/assets_paths/shared_assets_root.dart';
import '../../../configs/constants/color.dart';
import '../../../models/product/temp_class.dart';
import '../account/account_screen.dart';
import '../account/local_widgets/getter.dart';
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
  final userID = AccountScreen.localUserID;
  final referenceDatabase = AccountScreen.localRefDatabase;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final otherSideUserID = args['otherSideUserID'].toString();
    final tradingID = args['tradingID'].toString();
    final products = [
      productsData[0],
      productsData[1],
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
                        color: kTextColor,
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
                              '$chatScreenAvaFolder/user.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 25),
                          Container(
                            width: width * 0.5,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 21,
                                color: kTextColor,
                              ),
                              child: GetUserName(
                                documentId: otherSideUserID,
                                isStream: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    //color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: kTextColor,
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
                      FutureBuilder<DocumentSnapshot>(
                          future: referenceDatabase
                              .collection('tradings')
                              .doc(tradingID)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red.withOpacity(0.6),
                                  ));
                            }

                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return Text('Document does not exist',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red.withOpacity(0.6),
                                  ));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final _trading =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              final amIOwner = _trading['owner'] == userID;
                              final posts = !amIOwner
                                  ? _trading['ownerPosts'] as List
                                  : _trading['offerUserPosts'] as List;
                              return Column(
                                children: [
                                  for (var post in posts)
                                    FutureBuilder<DocumentSnapshot>(
                                      future: referenceDatabase
                                          .collection('posts')
                                          .doc(post.toString())
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text('Something went wrong',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ));
                                        }

                                        if (snapshot.hasData &&
                                            !snapshot.data!.exists) {
                                          return Text('Document does not exist',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          final post = snapshot.data!.data()
                                              as Map<String, dynamic>;

                                          return Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 70,
                                                  height: 70,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.asset(
                                                      products[0].images[0],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                Expanded(
                                                  child: Text(
                                                    post['name'].toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.blue),
                                          ),
                                        );
                                      },
                                    )
                                ],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            );
                          }),
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
                        color: kTextColor,
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
                        onRatingSelected: (rating) {},
                        // onRatingSelected: (rating) {
                        //   setState(() {
                        //     _rating = rating;
                        //   });
                        // print('rating $_rating');
                        // },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('userID', userID));
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'referenceDatabase', referenceDatabase));
  }
}
