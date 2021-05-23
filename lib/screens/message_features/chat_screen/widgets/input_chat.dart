import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';

class ChatInput extends StatelessWidget {
  ChatInput({
    Key? key,
  }) : super(key: key);
  final inputFormKey = GlobalKey<FormState>();

  void sendMessage() {
    if (inputFormKey.currentState!.validate()) {
      //TODO validate mới cho thực hiện gửi tin nhắn
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  child: const Icon(
                    Icons.menu,
                    color: kPrimaryColor,
                    size: 20,
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
                  child: const Icon(
                    Icons.mic,
                    color: kPrimaryColor,
                    size: 20,
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
                color: kBackGroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Form(
                key: inputFormKey,
                child: TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? '' : null;
                  },
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
          ),
          const SizedBox(width: 3),
          Container(
            height: height,
            child: Center(
              child: GestureDetector(
                onTap: sendMessage,
                child: Container(
                  height: 35,
                  width: 35,
                  child: const Icon(
                    Icons.send_rounded,
                    color: kPrimaryColor,
                    size: 20,
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
                  icon: const Icon(
                    Icons.photo_camera,
                    size: 45,
                    color: kPrimaryColor,
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
                  icon: const Icon(
                    Icons.image,
                    size: 45,
                    color: kPrimaryColor,
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
    properties.add(DiagnosticsProperty<GlobalKey<FormState>>(
        'inputFormKey', inputFormKey));
  }
}
