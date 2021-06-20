import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/constants/app_colors.dart';
import 'package:we_trade/models/cloud_firestore/post_card_model/post_card/post_card.dart';
import 'package:we_trade/services/firestore/firestore_database.dart';
import 'package:we_trade/services/post_feature/post_service_algolia.dart';
import 'package:we_trade/ui/message_features/const_string/const_str.dart';
import 'package:we_trade/widgets/item_post_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static String routeName = '/chat/add_chat';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();
  PostServiceAlgolia serviceAlgolia = PostServiceAlgolia();
  List<PostCard> posts = [];
  bool isLoading = true;

  void initiateSearch() {
    if (searchTextController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      serviceAlgolia.searchPostCard(searchTextController.text).then((listId) {
        final _firestoreDatabase = context.read<FirestoreDatabase>();
        _firestoreDatabase
            .getPostCardsByPostIdList(postIdList: listId)
            .then((value) => setState(() {
          posts = value;
          isLoading = false;
        }));
      });
    } else {
      posts = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchTextController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Search here ...',
                      border: InputBorder.none,
                      helperMaxLines: 1,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.kTextLightColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: initiateSearch,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
                // TODO vũ overlay filter ở đây, thêm nút sort nữa
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: posts.isNotEmpty
                      ? !isLoading
                      ? Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: posts
                        .map(
                          (post) => ItemPostCard(postCard: post),
                    )
                        .toList(),
                  )
                      : Center(
                    child: Column(
                      children: [
                        Lottie.network(
                          messageLoadingStr2,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 20),
                        const Text(loadingDataStr),
                      ],
                    ),
                  )
                      : Center(
                    child: Text('no data'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}