import 'package:flutter/material.dart';
import '../../configs/constants/color.dart';

// ignore: use_key_in_widget_constructors
class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/changepassword';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu cũ',
                  ),
                    obscureText: true,

                  controller: _oldPasswordController,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu mới',
                  ),
                    obscureText: true,

                  controller: _newPasswordController,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Xác nhận mật khẩu mới',
                  ),
                    obscureText: true,

                  controller: _confirmPasswordController,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text('Lưu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
