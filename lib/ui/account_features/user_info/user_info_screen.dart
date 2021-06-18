import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../constants/app_colors.dart';
import '../../../services/algolia/algolia.dart';
import '../../../services/message/algolia_user_service.dart';
import '../utils.dart';
import './change_password_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/userinfo';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final referenceDatabase = FirebaseFirestore.instance;
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final Algolia algolia = Application.algolia;

  final _nameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isChanged = false;
  bool _isLoaded = false;
  Map<String, dynamic>? _user;
  int timeOut = 10;

  final _formKey = GlobalKey<FormBuilderState>();
  late FocusScopeNode node;

  @override
  void initState() {
    super.initState();
    try {
      referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) {
        _user = documentSnapshot.data();

        if (_user == null) {
          showMyNotificationDialog(
              context: context,
              title: 'Lỗi',
              content: 'Không có dữ liệu! Vui lòng thử lại.',
              handleFunction: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
          _nameController.text = _user!['name'].toString();
          _emailController.text = _user!['email'].toString();
          _phoneNumController.text = _user!['phoneNumber'].toString();
          _locationController.text = _user!['location'].toString();
          _bioController.text = _user!['bio'].toString();
          setState(() {
            _isLoaded = true;
          });
        }
      }).timeout(Duration(seconds: timeOut));
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print('Lỗi: $e');
      showMyNotificationDialog(
          context: context,
          title: 'Lỗi',
          content: 'Tải dữ liệu không thành công. Vui lòng thử lại!',
          handleFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    }
  }

  Future<void> _saveChange() async {
    setState(() {
      _isLoaded = false;
    });

    final data = <String, dynamic>{
      'objectID': userID,
      'name': _nameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneNumController.text,
      'location': _locationController.text,
      'bio': _bioController.text,
    };
    try {
      await referenceDatabase
          .collection('users')
          .doc(userID)
          .update(data)
          .then((_) async {
        setState(() {
          _isChanged = false;
          _isLoaded = true;
        });
        await showMyNotificationDialog(
            context: context,
            title: 'Thông báo',
            content: 'Thông tin thay đổi thành công!',
            handleFunction: () {
              Navigator.of(context).pop();
            });

        await UserServiceAlgolia().updateUser(data);
        //TODO: Nếu ai cần cập nhật  User(name, email, ...) của provider thì cập nhật ở đây
        //
      }).timeout(Duration(seconds: timeOut));
    } on FirebaseException catch (error) {
      // ignore: avoid_print
      print('Lỗi khi lưu: $error');
      await showMyNotificationDialog(
          context: context,
          title: 'Thông báo',
          content: 'Thao tác Không thành công. Vui lòng thử lại sau.',
          handleFunction: () {
            Navigator.of(context).pop();
            setState(() {
              _isLoaded = true;
            });
          });
    }
  }

  void _onChangedHandleFunction(String? value) {
    setState(() {
      _isChanged = true;
    });
  }

  void _onEdittingCompleteHandleFunction() {
    node.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
      ),
      body: _isLoaded
          ? GestureDetector(
              onTap: () => node.unfocus(),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                children: [
                  FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'email',
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
                            hintText: 'Nhập email',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context),
                          ]),
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          onChanged: _onChangedHandleFunction,
                          enabled: false,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'name',
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Họ và tên',
                            hintText: 'Nhập họ tên',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          onChanged: _onChangedHandleFunction,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'phone',
                          decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: 'Số điện thoại',
                            hintText: 'Nhập số điện thoại',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          controller: _phoneNumController,
                          onChanged: _onChangedHandleFunction,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'location',
                          decoration: const InputDecoration(
                            icon: Icon(Icons.location_on),
                            labelText: 'Địa chỉ',
                            hintText: 'Chọn địa chỉ',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          controller: _locationController,
                          onChanged: _onChangedHandleFunction,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'bio',
                          decoration: const InputDecoration(
                            icon: Icon(Icons.fact_check),
                            labelText: 'Giới thiệu bản thân',
                            hintText: 'Nhập lời giới thiệu...',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          textInputAction: TextInputAction.done,
                          controller: _bioController,
                          onChanged: _onChangedHandleFunction,
                          maxLength: 300,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isChanged
                    ? () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          // print(_formKey.currentState!.value);
                          _saveChange();
                        } else {
                          // ignore: avoid_print
                          print('validation failed');
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary:
                      _isChanged ? Theme.of(context).primaryColor : Colors.grey,
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
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.kPrimaryLightColor,
                ),
                child: const Text(
                  'Đổi mật khẩu',
                  style: TextStyle(color: AppColors.kTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('timeOut', timeOut));
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
    properties.add(StringProperty('userID', userID));
    properties.add(DiagnosticsProperty<FirebaseFirestore>(
        'referenceDatabase', referenceDatabase));
    properties.add(DiagnosticsProperty<Algolia>('algolia', algolia));
  }
}
