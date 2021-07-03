import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../../models/cloud_firestore/post_card_model/post_card_item/post_card_item.dart';
import '../../../../widgets/item_post_card.dart';
import '../shared_widgets/getting_data_status.dart';

class DesiredPostScreen extends StatefulWidget {
  const DesiredPostScreen({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final List<String> posts;
  @override
  _DesiredPostScreenState createState() => _DesiredPostScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('posts', posts));
  }
}

class _DesiredPostScreenState extends State<DesiredPostScreen> {
  final userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final referenceDatabase = FirebaseFirestore.instance;
    final _posts = widget.posts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm bài đăng mong muốn'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: _posts.isNotEmpty
              ? Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: _posts.map(
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

                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return const DataDoesNotExist();
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final post =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              final item = PostCardItem(
                                image: post['item']['image'].toString(),
                                condition: post['item']['condition'].toString(),
                                district: post['item']['district'].toString(),
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
                                  verticalPadding: 80, horizontalPadding: 30),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                )
              : const Center(
                  child: CenterNotificationWhenHaveNoRecord(
                      text: 'Không tìm thấy sản phẩm phù hợp.'),
                ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userID', userID));
  }
}
