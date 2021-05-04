import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/chat/temp_class.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key, required this.userDetail}) : super(key: key);

  final UserDetail userDetail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Họ và tên',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                hintText: '\n',
                hintStyle: TextStyle(height: 2),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              initialValue: userDetail.user.name,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'SĐT',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                hintText: '\n',
                hintStyle: TextStyle(height: 2),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              initialValue: userDetail.phone,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                hintText: '\n',
                hintStyle: TextStyle(height: 2),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              initialValue: userDetail.email,
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Địa chỉ',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                hintText: '\n',
                hintStyle: TextStyle(height: 2),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              maxLines: 3,
              initialValue: userDetail.address,
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<UserDetail>('userDetail', userDetail));
  }
}
