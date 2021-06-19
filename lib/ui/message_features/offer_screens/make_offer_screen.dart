import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/cloud_firestore/post_card_model/post_card/post_card.dart';
import '../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../services/firestore/firestore_database.dart';
import '../../../services/trading_feature/trading_service_firestore.dart';
import '../../../widgets/custom_material_button.dart';
import '../../../widgets/item_post_card.dart';
import '../const_string/const_str.dart';
// import '../../../widgets/item_post_card.dart';

class MakeOfferScreen extends StatefulWidget {
  const MakeOfferScreen({
    Key? key,
    required this.otherUserPostId,
  }) : super(key: key);
  final String otherUserPostId;
  @override
  _MakeOfferScreenState createState() => _MakeOfferScreenState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('otherUserPostId', otherUserPostId));
  }
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  late bool _isHaveMoney = false;
  late List<String> choosedPostsId = [];
  late List<PostCard> posts = [];
  late bool loading = true;

  void clickPostCard(String postId) {
    if (!choosedPostsId.contains(postId)) {
      setState(() {
        choosedPostsId.add(postId);
      });
    } else {
      setState(() {
        choosedPostsId.remove(postId);
      });
    }
  }

  Future<void> sendOfferClick() async {
    setState(() {
      loading = true;
    });
    final thisUserId = Provider.of<User?>(context, listen: false)!.uid!;
    if (_isHaveMoney) {
      await TradingServiceFireStore()
          .addTrading(
              makeOfferUser: thisUserId,
              ownerPost: widget.otherUserPostId,
              offerUserPosts: choosedPostsId,
              money: int.parse(_textEditingController.text))
          .then((value) {
        Navigator.of(context).pop(_textEditingController.text);
      });
    } else {
      if (choosedPostsId.isNotEmpty) {
        await TradingServiceFireStore()
            .addTrading(
          makeOfferUser: thisUserId,
          ownerPost: widget.otherUserPostId,
          offerUserPosts: choosedPostsId,
        )
            .then((value) {
          Navigator.of(context).pop(_textEditingController.text);
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Widget buildListPostCard() {
    return loading
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Lottie.network(messageLoadingStr2, width: 100, height: 100),
            const Text('loading ...'),
          ])
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: posts.isNotEmpty
                ? Row(
                    children: [
                      ...List.generate(
                        posts.length,
                        (index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  clickPostCard(posts[index].postId!);
                                },
                                child: Stack(
                                  children: [
                                    ItemPostCard(
                                        isNavigateToDetailScreen: false,
                                        postCard: posts[index]),
                                    if (choosedPostsId
                                        .contains(posts[index].postId))
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: const Icon(
                                              Icons.check_box_rounded),
                                          color: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          );
                        },
                      )
                    ],
                  )
                : Row(
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        'no data',
                        style: TextStyle(color: AppColors.kReviewTextLabel),
                      ),
                    ],
                  ));
  }

  @override
  void initState() {
    super.initState();
    final thisUserId = Provider.of<User?>(context, listen: false)!.uid!;
    final _firestoreDatabase = context.read<FirestoreDatabase>();
    _firestoreDatabase.getPostCardsByUserId(userId: thisUserId).then((value) {
      setState(() {
        loading = false;
        posts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAKE OFFER'),
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
                    const SizedBox(height: 5),
                    const Text(
                      'Tất cả sản phẩm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildListPostCard(),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: _isHaveMoney,
                              onChanged: (value) {
                                setState(() {
                                  _isHaveMoney = value!;
                                });
                              },
                            ),
                            const Text(
                              'Thêm tiền',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _textEditingController,
                              validator: (value) {
                                if (value == null) {
                                  return 'Invalid Field';
                                }
                                return int.tryParse(value) != null
                                    ? null
                                    : 'Invalid Field';
                              },
                              maxLength: 10,
                              enabled: _isHaveMoney,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                hintText: 'VND',
                                hintStyle: TextStyle(height: 2),
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kTextLightColor,
                                ),
                              ),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomMaterialButton(
                        press: () {
                          Navigator.of(context).pop();
                        },
                        isFilled: false,
                        text: 'Hủy',
                        width: MediaQuery.of(context).size.width / 4,
                        fontSize: 15,
                        height: 40),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CustomMaterialButton(
                        press: () {
                          if (_formKey.currentState!.validate() ||
                              !_isHaveMoney) {
                            sendOfferClick();
                          }
                        },
                        text: 'Gửi offer',
                        width: MediaQuery.of(context).size.width / 4,
                        fontSize: 15,
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
    properties.add(IterableProperty<String>('choosedPostsId', choosedPostsId));
    properties.add(IterableProperty<PostCard>('posts', posts));
    properties.add(DiagnosticsProperty<bool>('loading', loading));
  }
}
