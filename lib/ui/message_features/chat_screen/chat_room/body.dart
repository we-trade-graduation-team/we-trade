import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/cloud_firestore/user/user.dart';
import '../../../../models/ui/shared_models/product_model.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../const_string/const_str.dart';
import '../../shared_widgets/offer_card.dart';
import '../widgets/message_tile.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.chatRoomId,
    required this.userAndAva,
  }) : super(key: key);
  final String chatRoomId;
  final Map<String, String> userAndAva;

  @override
  _BodyState createState() => _BodyState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('chatRoomId', chatRoomId));
    properties.add(
        DiagnosticsProperty<Map<String, String>>('userAndAva', userAndAva));
  }
}

class _BodyState extends State<Body> {
  MessageServiceFireStore dataServiceFireStore = MessageServiceFireStore();
  TextEditingController messageTextController = TextEditingController();
  late User thisUser = Provider.of<User?>(context, listen: false)!;
  // ignore: diagnostic_describe_all_properties
  late Stream<QuerySnapshot> chats;

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return MessageTile(
                    time: int.parse(data[timeStr].toString()),
                    message: data[messageStr].toString(),
                    senderImage:
                        widget.userAndAva.containsKey(data[senderIdStr])
                            ? widget.userAndAva[data[senderIdStr]].toString()
                            : '',
                    isOutGroupMessage: data[senderIdStr].toString().isEmpty,
                    sendByMe: thisUser.uid == data[senderIdStr],
                  );
                })
            : Container();
      },
    );
  }

  Future<void> addMessageToChatRoom() async {
    if (messageTextController.text.isNotEmpty) {
      final name = (thisUser.displayName!.isNotEmpty
          ? thisUser.displayName
          : thisUser.email)!;
      await dataServiceFireStore
          .addMessageToChatRoom(thisUser.uid!, 0, messageTextController.text,
              widget.chatRoomId, name)
          .then((value) => setState(() {
                messageTextController.text = '';
              }));
    }
  }

  @override
  void initState() {
    dataServiceFireStore.getChats(widget.chatRoomId).then((result) {
      setState(() {
        chats = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //check if have offer chưa trả lời
    //nếu có thì trả ra card_offer ghim đầu
    //ko thì thôi :v
    const isHaveOfferDeal = false;
    final offerSideProducts = [allProduct[0], allProduct[1]];
    const money = 100000;
    final forProduct = allProduct[3];

    return Column(
      children: [
        if (isHaveOfferDeal)
          Container(
            alignment: Alignment.topCenter,
            child: OfferCard(
                offerSideProducts: offerSideProducts,
                forProduct: forProduct,
                offerSideMoney: money),
          ),
        Expanded(child: chatMessages()),
        Container(
          alignment: Alignment.bottomLeft,
          child: buildInputChat(),
        ),
      ],
    );
  }

  Widget buildInputChat() {
    const height = 48.0;
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showBottomSheet(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showBottomSheet(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.mic,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 14 * 6 + 20),
              decoration: BoxDecoration(
                color: AppColors.kScreenBackgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: messageTextController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Write message...',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: addMessageToChatRoom,
                child: Container(
                  height: 35,
                  width: 40,
                  child: Icon(
                    Icons.send_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      barrierColor: Colors.grey[300]!.withOpacity(0.5),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.photo_camera,
                    size: 45,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 0),
                const Text('camera'),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.image,
                    size: 45,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Text('Images'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'messageTextController', messageTextController));
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'dataService', dataServiceFireStore));
    properties.add(DiagnosticsProperty<User>('thisUser', thisUser));
  }
}
