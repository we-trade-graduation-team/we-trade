import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/changepassword';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();
  late FocusScopeNode node;

  void _onEdittingCompleteHandleFunction() {
    node.unfocus();
  }

  bool _isLoaded = true;

  Future<void> _savePassword() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      if (_confirmPasswordController.text != _newPasswordController.text) {
        await showMyNotificationDialog(
            context: context,
            title: 'Thông báo',
            content: 'Xác nhận mật khẩu không chính xác.',
            handleFunction: () {
              Navigator.of(context).pop();
            });
      } else {
        setState(() {
          _isLoaded = false;
        });

        final user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          try {
            final username = user.email.toString();
            final credential = EmailAuthProvider.credential(
                email: username, password: _oldPasswordController.text);
            await FirebaseAuth.instance.currentUser!
                .reauthenticateWithCredential(credential);
            await user.updatePassword(_newPasswordController.text);
            await showMyNotificationDialog(
                context: context,
                title: 'Thông báo',
                content: 'Thay đổi mật khẩu thành công.',
                handleFunction: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
          } on FirebaseAuthException catch (_) {
            await showMyNotificationDialog(
                context: context,
                title: 'Thông báo',
                content:
                    'Mật khẩu cũ không đúng hoặc có lỗi xảy ra. Vui lòng thử lại sau.',
                handleFunction: () {
                  Navigator.of(context).pop();
                });
          }
          setState(() {
            _isLoaded = true;
          });
        } else {
          //user must login to do this action
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
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
                children: [
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'oldpassword',
                          decoration: const InputDecoration(
                            labelText: 'Mật khẩu cũ',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          obscureText: true,
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          controller: _oldPasswordController,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'newpassword',
                          decoration: const InputDecoration(
                            labelText: 'Mật khẩu mới',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 6),
                          ]),
                          obscureText: true,
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          controller: _newPasswordController,
                        ),
                        const SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'confirmpassword',
                          decoration: const InputDecoration(
                            labelText: 'Xác nhận mật khẩu mới',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 6),
                          ]),
                          obscureText: true,
                          onEditingComplete: _onEdittingCompleteHandleFunction,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          controller: _confirmPasswordController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoaded ? _savePassword : null,
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: const Text('Lưu'),
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
    properties.add(DiagnosticsProperty<FocusScopeNode>('node', node));
  }
}
