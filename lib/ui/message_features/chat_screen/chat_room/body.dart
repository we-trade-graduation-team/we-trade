import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_colors.dart';
import '../../../../models/cloud_firestore/user_model/user/user.dart';
import '../../../../services/message/firestore_message_service.dart';
import '../../../../services/trading_feature/trading_service_firestore.dart';
import '../../../../utils/helper/image_data_storage_helper/image_data_storage_helper.dart';
import '../../../../widgets/custom_material_button.dart';
import '../../const_string/const_str.dart';
import '../../helper/ulti.dart';
import '../../shared_widgets/offer_card.dart';
import '../widgets/message_tile.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.chatRoomId,
    required this.userAndAva,
    required this.userAndName,
  }) : super(key: key);
  final String chatRoomId;
  final Map<String, String> userAndAva, userAndName;

  @override
  _BodyState createState() => _BodyState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('chatRoomId', chatRoomId));
    properties.add(
        DiagnosticsProperty<Map<String, String>>('userAndAva', userAndAva));
    properties.add(
        DiagnosticsProperty<Map<String, String>>('userAndName', userAndName));
  }
}

class _BodyState extends State<Body> {
  MessageServiceFireStore messageServiceFireStore = MessageServiceFireStore();
  TextEditingController messageTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  late User thisUser = Provider.of<User?>(context, listen: false)!;
  // ignore: diagnostic_describe_all_properties
  late Stream<QuerySnapshot> chats;
  // ignore: diagnostic_describe_all_properties
  late Stream<DocumentSnapshot<Map<String, dynamic>>> seenHistory;
// ignore: diagnostic_describe_all_properties
  late Stream<DocumentSnapshot<Map<String, dynamic>>> tradingDeal;

  late Map<String, String> seenHistoryMap = {};
  late bool isHaveOfferDeal = false;
  late bool isShowGallery = false;
  late bool isLoadingImage = false;
  List<Asset> images = <Asset>[];

//UI =======================================
  Widget buildSeenHistory() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: seenHistory,
        builder: (context, snapshot) {
          seenHistoryMap = {};
          if (snapshot.hasData) {
            seenHistoryMap = (snapshot.data!.data() as Map<String, dynamic>)
                .cast<String, String>();
          }
          return Container();
        });
  }

  Widget buildMessageTile() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lastMessageId = snapshot.data!.docs.first.id;
          messageServiceFireStore.updateMySeenHistory(
              widget.chatRoomId, thisUser.uid!, lastMessageId);
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                final data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                final usersImageWhoSeen = <String>[];
                seenHistoryMap.forEach((key, value) {
                  if (value == snapshot.data!.docs[index].id &&
                      key != thisUser.uid) {
                    usersImageWhoSeen.add(widget.userAndAva[key].toString());
                  }
                });
                return MessageTile(
                  usersImageWhoSeen: usersImageWhoSeen,
                  type: int.parse(data[typeStr].toString()),
                  time: int.parse(data[timeStr].toString()),
                  message: data[messageStr].toString(),
                  senderName: widget.userAndName.containsKey(data[senderIdStr])
                      ? widget.userAndName[data[senderIdStr]].toString()
                      : '',
                  senderImage: widget.userAndAva.containsKey(data[senderIdStr])
                      ? widget.userAndAva[data[senderIdStr]].toString()
                      : '',
                  isOutGroupMessage: data[senderIdStr].toString().isEmpty,
                  sendByMe: thisUser.uid == data[senderIdStr],
                );
              });
        }
        return Container();
      },
    );
  }

  Widget buildOfferDealCard() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: tradingDeal,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data() != null) {
              final tradingID = (snapshot.data!.data()
                      as Map<String, dynamic>)['latestTrading']
                  .toString();
              return OfferCard(
                tradingID: tradingID,
              );
            }
          }
          return Container();
        });
  }

  Widget buildGridViewSelectedImages() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return images.isNotEmpty
        //isLoadingImage
        ? Container(
            height: height / 3,
            width: width,
            child: Stack(
              children: [
                if (!isLoadingImage)
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: List.generate(images.length, (index) {
                      final asset = images[index];
                      return AssetThumb(
                        asset: asset,
                        width: 300,
                        height: 300,
                      );
                    }),
                  )
                else
                  Lottie.network(messageLoadingStr2, width: 100, height: 100),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CustomMaterialButton(
                    press:
                        addMessageImageToChatRoom, // bấm đẩy (F12) để coi hàm chạy push image lên
                    text: 'GỬI',
                    width: MediaQuery.of(context).size.width - 200,
                    height: 30,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget buildGallery() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: loadAssets,
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.image,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Text('Images'),
            ],
          ),
          buildGridViewSelectedImages(),
        ],
      ),
    );
  }

// function Message send ============================
  Future<void> addMessageToChatRoom(String contentToSend, int type) async {
    final name = HelperClass.finalSenderName(thisUser.name, thisUser.email);

    await messageServiceFireStore.addMessageToChatRoom(
        thisUser.uid!, type, contentToSend, widget.chatRoomId, name);
  }

  Future<void> addMessageTextToChatRoom() async {
    if (messageTextController.text.trim().isNotEmpty) {
      await addMessageToChatRoom(messageTextController.text.trim(), textType)
          .then((value) {
        setState(() {
          messageTextController.text = '';
        });
      });
    }
  }

  void addMessageImageToChatRoom() {
    if (images.isNotEmpty) {
      setState(() {
        isLoadingImage = true;
      });
      for (final image in images) {
        ImageDataStorageHelper.getImageURL(
                chatRoomCollection,
                '${widget.chatRoomId}_${DateTime.now().millisecondsSinceEpoch}',
                image)
            .then((imageURL) {
          addMessageToChatRoom(imageURL, imageType)
              .then((value) => setState(() {
                    isLoadingImage = false;
                    images.clear();
                    isShowGallery = false;
                  }));
        });
      }
    }
  }

// function show gallery =======================
  Future<bool> onBackPress() {
    if (isShowGallery) {
      setState(() {
        isShowGallery = false;
        images.clear();
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowGallery = false;
        images.clear();
      });
    }
  }

  void getGallery() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowGallery = !isShowGallery;
      if (!isShowGallery) {
        images.clear();
      }
    });
  }

  Future<void> loadAssets() async {
    var resultList = <Asset>[]; //start here list ảnh trả ra tạm thời

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: 'chat',
          doneButtonTitle: 'Fatto',
        ),
        materialOptions: const MaterialOptions(
          statusBarColor: '#CCD2E3',
          actionBarColor: '#6F35A5',
          actionBarTitle: 'CHỌN ẢNH',
          allViewTitle: 'All Photos',
          useDetailsView: false,
          selectCircleStrokeColor: '#ffffff',
        ),
      );
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      //error = e.toString();
      //log(error);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      images = resultList; //nếu chạy thành công thì setState hiện list ảnh lên
    });
  }

  @override
  void initState() {
    TradingServiceFireStore()
        .getLatestTradingForChatRoom(chatRoomId: widget.chatRoomId)
        .then((value) => setState(() {
              tradingDeal = value;
            }));
    messageServiceFireStore.getChats(widget.chatRoomId).then((result) {
      setState(() {
        chats = result;
      });
    });
    messageServiceFireStore.getSeenHistory(widget.chatRoomId).then((result) {
      setState(() {
        seenHistory = result;
      });
    });
    focusNode.addListener(onFocusChange);
    isShowGallery = false;
    images.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Stack(
        children: [
          Column(
            children: [
              buildSeenHistory(),
              buildOfferDealCard(),
              Expanded(child: buildMessageTile()),
              if (isShowGallery) buildGallery() else Container(),
              Container(
                alignment: Alignment.bottomLeft,
                child: buildInputChat(),
              ),
            ],
          ),
        ],
      ),
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
                onTap: getGallery,
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
                onTap: () {},
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
                focusNode: focusNode,
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
                onTap: addMessageTextToChatRoom,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'messageTextController', messageTextController));
    properties.add(DiagnosticsProperty<User>('thisUser', thisUser));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode));
    properties
        .add(DiagnosticsProperty<bool>('isHaveOfferDeal', isHaveOfferDeal));
    properties.add(DiagnosticsProperty<bool>('isShowGallery', isShowGallery));
    properties.add(IterableProperty<Asset>('images', images));
    properties.add(DiagnosticsProperty<MessageServiceFireStore>(
        'messageServiceFireStore', messageServiceFireStore));
    properties.add(DiagnosticsProperty<bool>('isLoadingImage', isLoadingImage));
    properties.add(DiagnosticsProperty<Map<String, String>>(
        'seenHistoryMap', seenHistoryMap));
  }
}
