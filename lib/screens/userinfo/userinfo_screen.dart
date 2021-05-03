import 'package:flutter/material.dart';
import '../../configs/constants/color.dart';
import 'changepassword_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/userinfo';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _nameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
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
                    icon: Icon(Icons.person),
                    labelText: 'Họ và tên',
                    hintText: 'Nhập họ tên',
                  ),
                  controller: _nameController,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Số điện thoại',
                    hintText: 'Nhập số điện thoại',
                  ),
                  controller: _phoneNumController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Nhập Email',
                  ),
                  controller: _emailController,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: 'Địa chỉ',
                    hintText: 'Nhập địa chỉ',
                  ),
                  controller: _locationController,
                ),
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.badge),
                    labelText: 'Giới thiệu bản thân',
                    hintText: 'Nhập lời giới thiệu...',
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
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
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ChangePasswordScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryLightColor,
                ),
                child: const Text(
                  'Đổi mật khẩu',
                  style: TextStyle(color: kTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
