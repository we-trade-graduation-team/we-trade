import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card_item/post_card_item.dart';
import '../../../../widgets/item_post_card.dart';
import '../../../account_features/shared_widgets/getting_data_status.dart';
import '../../../account_features/utils.dart';

class WishTab extends StatefulWidget {
  const WishTab({Key? key}) : super(key: key);

  @override
  _WishTabState createState() => _WishTabState();
}

class _WishTabState extends State<WishTab> {
  final userID = FirebaseAuth.instance.currentUser!.uid;

  // Widget buildGetListID() {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    final referenceDatabase = FirebaseFirestore.instance;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
            stream:
                referenceDatabase.collection('users').doc(userID).snapshots(),
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
                    });
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = snapshot.data!.data() as Map<String, dynamic>;
              late var posts = <String>[];
              if (data.containsKey('wishList')) {
                posts =
                    (data['wishList'] as List<dynamic>).cast<String>().toList();
              }

              return posts.isNotEmpty
                  ? Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 15,
                        children: posts.map(
                          (post) {
                            return FutureBuilder<DocumentSnapshot>(
                              future: referenceDatabase
                                  .collection('postCards')
                                  .doc(post)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const WentWrong();
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return const DataDoesNotExist();
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  final post = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  final item = PostCardItem(
                                    image: post['item']['image'].toString(),
                                    condition:
                                        post['item']['condition'].toString(),
                                    district:
                                        post['item']['district'].toString(),
                                    price: double.parse(
                                        post['item']['price'].toString()),
                                  );
                                  final postCard = PostCard(
                                    item: item,
                                    title: post['title'].toString(),
                                    postId: snapshot.data!.id,
                                  );

                                  return ItemPostCard(postCard: postCard);
                                }
                                return const Center(
                                  child: CustomLinearProgressIndicator(
                                      verticalPadding: 80,
                                      horizontalPadding: 30),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
                    )
                  : const CenterNotificationWhenHaveNoRecord(
                      text: 'Bạn chưa có bài đăng nào ở đây');
            }),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userID', userID));
  }
}
