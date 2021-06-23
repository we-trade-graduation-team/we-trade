import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../constants/app_colors.dart';

import '../utils.dart';

class ReplyButton extends StatefulWidget {
  const ReplyButton({Key? key, required this.ratingID}) : super(key: key);

  final String ratingID;

  @override
  _ReplyButtonState createState() => _ReplyButtonState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('ratingID', ratingID));
  }
}

class _ReplyButtonState extends State<ReplyButton> {
  final referenceDatabase = FirebaseFirestore.instance;

  bool showReplyTextField = false;
  bool hasReplySent = false;
  final _replyController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // myFocusNode.dispose();

    super.dispose();
  }

  Future<void> _sendReply() async {
    final replyText = _replyController.text.trim();
    try {
      await referenceDatabase
          .collection('ratings')
          .doc(widget.ratingID)
          .update({'reply': replyText}).then((value) {
        setState(() {
          hasReplySent = !hasReplySent;
        });
        showMyNotificationDialog(
            context: context,
            title: 'Thành công',
            content: 'Gửi phản hồi thành công!',
            handleFunction: () {
              Navigator.of(context).pop();
            });
      });
    } on FirebaseException catch (_) {
      // print('Lỗi khi lưu: $error');
      return showMyNotificationDialog(
          context: context,
          title: 'Thất bại',
          content: 'Thao tác không thành công. Vui lòng thử lại sau.',
          handleFunction: () {
            Navigator.of(context).pop();
            // setState(() {
            //   _isLoaded = true;
            // });
          });
    }
  }

  List<Widget> _buildButtonsForReplyTextFieldActions() {
    return [
      ElevatedButton(
        onPressed: () {
          _formKey.currentState!.save();
          if (_formKey.currentState!.validate()) {
            myFocusNode.unfocus();
            _sendReply();
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          elevation: 4,
          onPrimary: AppColors.kPrimaryLightColor,
        ),
        child: const Text('Gửi'),
      ),
      const SizedBox(width: 10),
      OutlinedButton(
        onPressed: () {
          setState(() {
            showReplyTextField = !showReplyTextField;
          });
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          'Hủy',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ];
  }

  Widget _buildShowReplyButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showReplyTextField = !showReplyTextField;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        elevation: 4,
        onPrimary: AppColors.kPrimaryLightColor,
      ),
      child: const Text('Phản hồi'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showReplyTextField)
          FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: FormBuilderTextField(
              name: 'reply',
              focusNode: myFocusNode,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
              decoration: const InputDecoration(
                hintText: 'Nhập phản hồi...',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              textInputAction: TextInputAction.newline,
              controller: _replyController,
              maxLength: 200,
              maxLines: 4,
              readOnly: hasReplySent,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (showReplyTextField && !hasReplySent)
              ..._buildButtonsForReplyTextFieldActions()
            else
              _buildShowReplyButton(),
          ],
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<bool>('showReplyTextField', showReplyTextField));
    properties.add(DiagnosticsProperty<FocusNode>('myFocusNode', myFocusNode));
    properties.add(DiagnosticsProperty('referenceDatabase', referenceDatabase));
    properties.add(DiagnosticsProperty<bool>('hasReplySent', hasReplySent));
  }
}
