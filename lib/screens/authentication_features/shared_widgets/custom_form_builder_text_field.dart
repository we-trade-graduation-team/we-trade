import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../configs/constants/color.dart';

class CustomFormBuilderTextField extends StatefulWidget {
  const CustomFormBuilderTextField({
    Key? key,
    required this.name,
    required this.labelText,
    required this.onEditingComplete,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  final String name, labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final VoidCallback onEditingComplete;
  final AutovalidateMode autovalidateMode;
  final TextInputType keyboardType;

  @override
  _CustomFormBuilderTextFieldState createState() =>
      _CustomFormBuilderTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('labelText', labelText));
    properties.add(ObjectFlagProperty<String? Function(String? p1)>.has(
        'validator', validator));
    properties.add(StringProperty('name', name));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText));
    properties.add(
        EnumProperty<TextInputAction?>('textInputAction', textInputAction));
    properties.add(ObjectFlagProperty<VoidCallback>.has(
        'onEditingComplete', onEditingComplete));
    properties.add(
        EnumProperty<AutovalidateMode>('autovalidateMode', autovalidateMode));
        properties.add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType));
  }
}

class _CustomFormBuilderTextFieldState
    extends State<CustomFormBuilderTextField> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: myFocusNode,
      name: widget.name,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: myFocusNode.hasFocus
              ? kPrimaryColor
              : kTextColor.withOpacity(0.3),
          fontWeight: FontWeight.w600,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: TextInputAction.next,
      obscureText: widget.obscureText,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.keyboardType,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FocusNode>('myFocusNode', myFocusNode));
  }
}
