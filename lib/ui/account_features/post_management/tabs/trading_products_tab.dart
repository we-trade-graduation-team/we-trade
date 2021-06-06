import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../account_screen/account_screen.dart';
import '../../shared_widgets/geting_data_status.dart';
import '../../shared_widgets/trading_prod_card.dart';
import '../../utils.dart';

class TradingProductsTab extends StatefulWidget {
  const TradingProductsTab({Key? key, required this.isHiddenPosts})
      : super(key: key);

  final bool isHiddenPosts;

  @override
  _TradingProductsTabState createState() => _TradingProductsTabState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<bool>('isOutOfDatePosts', isHiddenPosts));
  }
}

class _TradingProductsTabState extends State<TradingProductsTab> {
  final userID = AccountScreen.localUserID;

  @override
  Widget build(BuildContext context) {
    final referenceDatabase = AccountScreen.localRefDatabase;

    return StreamBuilder<DocumentSnapshot>(
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
          final posts = widget.isHiddenPosts
              ? data['hiddenPosts'] as List
              : data['posts'] as List;

          return posts.isNotEmpty
              ? ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: referenceDatabase
                          .collection('posts')
                          .doc(posts[index].toString())
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const WentWrong();
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const DataDoesNotExist();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          final post =
                              snapshot.data!.data() as Map<String, dynamic>;
                          post['id'] = snapshot.data!.id;
                          final temp = post['createAt'] as Timestamp;
                          final dateTime = temp.toDate();
                          return TradingProductCard(
                            key: ValueKey(post['id'].toString()),
                            id: post['id'].toString(),
                            name: post['name'].toString(),
                            price: post['price'].toString(),
                            imageUrl: post['imagesUrl'][0].toString(),
                            dateTime: dateTime,
                            isHiddenPost: widget.isHiddenPosts,
                          );
                        }
                        return const Center(
                          child: CustomLinearProgressIndicator(
                              verticalPadding: 80, horizontalPadding: 30),
                        );
                      },
                    );
                  },
                )
              : const Center(
                  child: Text(
                    'Chưa có dữ liệu.',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black45,
                    ),
                  ),
                );
        });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty('userID', userID));
  }
}
