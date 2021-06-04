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

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    if (_confirmPasswordController.text !=
                        _newPasswordController.text) {
                      showMyNotificationDialog(
                          context: context,
                          title: 'Thông báo',
                          content: 'Xác nhận mật khẩu không chính xác.',
                          handleFunction: () {
                            Navigator.of(context).pop();
                          });
                    } else {
                      //TODO: compare pw in db
                      showMyNotificationDialog(
                          context: context,
                          title: 'Thông báo',
                          content: 'Thay đổi mật khẩu thành công.',
                          handleFunction: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                    }
                  }
                },
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
