import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date_time;

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/custom_user_avatar.dart';
import '../../../shared_features/image_zoom/image_zoom_effect.dart';
import '../../const_string/const_str.dart';

class MessageTile extends StatefulWidget {
  const MessageTile(
      {Key? key,
      required this.message,
      required this.sendByMe,
      this.isOutGroupMessage = false,
      this.senderImage = '',
      this.senderName = '',
      required this.time,
      required this.type,
      required this.usersImageWhoSeen})
      : super(key: key);

  final String message, senderImage, senderName;
  final int time, type;
  final bool sendByMe, isOutGroupMessage;
  final List<String> usersImageWhoSeen;

  @override
  State<MessageTile> createState() => _MessageTileState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
    properties
        .add(DiagnosticsProperty<bool>('isOutGroupMessage', isOutGroupMessage));
    properties.add(DiagnosticsProperty<bool>('sendByMe', sendByMe));
    properties.add(IntProperty('time', time));
    properties.add(StringProperty('senderImage', senderImage));
    properties.add(IntProperty('type', type));
    properties
        .add(IterableProperty<String>('usersImageWhoSeen', usersImageWhoSeen));
    properties.add(StringProperty('senderName', senderName));
  }
}

class _MessageTileState extends State<MessageTile> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return !widget.isOutGroupMessage
        ? Column(
            children: [
              Container(
                margin: widget.sendByMe
                    ? const EdgeInsets.only(left: 40)
                    : const EdgeInsets.only(right: 40),
                padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: widget.sendByMe ? 0 : 10,
                    right: widget.sendByMe ? 10 : 0),
                alignment: widget.sendByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!widget.sendByMe)
                      CustomUserAvatar(image: widget.senderImage, radius: 13),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: widget.sendByMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!widget.sendByMe)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              widget.senderName,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        buildContentSend(),
                        if (isVisible || widget.type == imageType)
                          const SizedBox(height: 5),
                        if (isVisible || widget.type == imageType)
                          Text(
                            date_time.DateFormat.yMd('en_US').add_jm().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(widget.time.toString()))),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                      ],
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: buildSeenImages()),
            ],
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: Column(
              children: [
                Text(
                  date_time.DateFormat.yMd('en_US').add_jm().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(widget.time.toString()))),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w300),
                ),
                Text(
                  widget.message,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ],
            ));
  }

  Widget buildSeenImages() {
    if (widget.usersImageWhoSeen.isNotEmpty) {
      final width = MediaQuery.of(context).size.width;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 20,
          width: width / 2,
          child: GridView.count(
            crossAxisCount: 10,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            children: List.generate(widget.usersImageWhoSeen.length, (index) {
              final asset = widget.usersImageWhoSeen[index];
              return CustomUserAvatar(image: asset, radius: 10);
            }),
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildContentSend() {
    if (widget.type == textType) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Container(
          padding:
              const EdgeInsets.only(top: 13, bottom: 13, left: 17, right: 17),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: widget.sendByMe
                ? Theme.of(context).primaryColor
                : AppColors.kScreenBackgroundColor,
          ),
          child: Text(widget.message,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: widget.sendByMe ? Colors.white : AppColors.kTextColor,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300)),
        ),
      );
    } else if (widget.type == imageType) {
      final themeColor = Theme.of(context).primaryColor;
      return GestureDetector(
        onTap: () {
          pushNewScreen<void>(
            context,
            screen: ImageZoomScreen(
              photoURL: widget.message,
              tittle: date_time.DateFormat.yMd('en_US').add_jm().format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(widget.time.toString()))),
            ),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: SizedBox(
            height: 200,
            width: 200,
            child: PinchZoom(
              zoomedBackgroundColor: Colors.black.withOpacity(0.5),
              //resetDuration: const Duration(milliseconds: 100),
              maxScale: 5,
              onZoomStart: () {},
              onZoomEnd: () {},
              image: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(70),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  ),
                ),
                errorWidget: (context, url, dynamic error) => Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/images/message/img_not_available.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                imageUrl: widget.message,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );
    } else if (widget.type == videoType) {
      return Container();
    } else {
      return Container();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', widget.message));
    properties.add(DiagnosticsProperty<bool>('sendByMe', widget.sendByMe));
    properties.add(StringProperty('image', widget.senderImage));
    properties.add(DiagnosticsProperty<bool>(
        'isOutGroupMessage', widget.isOutGroupMessage));
    properties.add(DiagnosticsProperty<bool>('isVisible', isVisible));
  }
}
