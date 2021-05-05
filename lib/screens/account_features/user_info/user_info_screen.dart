import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../configs/constants/color.dart';
import 'change_password_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/userinfo';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // ignore: diagnostic_describe_all_properties
  final referenceDatabase = FirebaseFirestore.instance;
  final _nameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _bioController = TextEditingController();

  // ignore: diagnostic_describe_all_properties
  final userID = 'mMl4IgenYanDSNvkylb5';
  // ignore: diagnostic_describe_all_properties
  bool _isChanged = false;
  bool _isLoaded = false;
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    referenceDatabase
        .collection('users')
        .doc(userID)
        .get()
        .then((documentSnapshot) {
          _user = documentSnapshot.data();
          _nameController.text = _user!['name'].toString();
          _emailController.text = _user!['email'].toString();
          _phoneNumController.text = _user!['phoneNumber'].toString();
          _locationController.text = _user!['location'].toString();
          _bioController.text = _user!['bio'].toString();

          setState(() {
            _isLoaded = true;
          });
        })
        .timeout(const Duration(seconds: 20))
        .catchError((error) {
          // print('Lỗi: $error');
          _showMyDialog(
              'Lỗi', 'Tải dữ liệu không thành công. Vui lòng thử lại!', () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        });
  }

  Future<void> _showMyDialog(
      String title, String content, Function handleFunction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                handleFunction();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _saveChange() {
    setState(() {
      _isLoaded = false;
    });
    final data = <String, dynamic>{
      'name': _nameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneNumController.text,
      'location': _locationController.text,
      'bio': _bioController.text,
    };
    referenceDatabase
        .collection('users')
        .doc(userID)
        .update(data)
        .then((value) {
          setState(() {
            _isChanged = false;
            _isLoaded = true;
          });

          _showMyDialog('Thành công', 'Thông tin thay đổi thành công!', () {
            Navigator.of(context).pop();
          });
        })
        .timeout(const Duration(seconds: 20))
        .catchError((error) {
          // ignore: avoid_print
          print('Lỗi khi lưu: $error');
          _showMyDialog(
              'Thất bại', 'Thao tác Không thành công. Vui lòng thử lại sau.',
              () {
            Navigator.of(context).pop();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
      ),
      body: _isLoaded
          ? GestureDetector(
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
                        maxLength: 50,
                        onChanged: (_) {
                          setState(() {
                            _isChanged = true;
                          });
                        },
                        controller: _nameController,
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Số điện thoại',
                          hintText: 'Nhập số điện thoại',
                        ),
                        maxLength: 20,
                        onChanged: (_) {
                          setState(() {
                            _isChanged = true;
                          });
                        },
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
                        maxLength: 100,
                        onChanged: (_) {
                          setState(() {
                            _isChanged = true;
                          });
                        },
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_on),
                          labelText: 'Địa chỉ',
                          hintText: 'Chọn địa chỉ',
                        ),
                        maxLength: 200,
                        controller: _locationController,
                        onChanged: (_) {
                          setState(() {
                            _isChanged = true;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Giới thiệu bản thân',
                          hintText: 'Nhập lời giới thiệu...',
                        ),
                        maxLength: 200,
                        maxLines: 4,
                        controller: _bioController,
                        onChanged: (_) {
                          setState(() {
                            _isChanged = true;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isChanged ? _saveChange : null,
                style: ElevatedButton.styleFrom(
                  primary: _isChanged ? kPrimaryColor : Colors.grey,
                ),
                child: const Text('Lưu'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  pushNewScreenWithRouteSettings<void>(
                    context,
                    settings: const RouteSettings(
                        name: ChangePasswordScreen.routeName),
                    screen: const ChangePasswordScreen(),
                    // withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // Navigator.of(context)
                  //     .pushNamed(ChangePasswordScreen.routeName);
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
