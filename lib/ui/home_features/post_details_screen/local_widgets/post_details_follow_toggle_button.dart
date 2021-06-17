import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/ui/home_features/detail_screen/user_followed_product.dart';
import '../../../../models/ui/shared_models/product_model.dart';

class FollowToggleButton extends StatefulWidget {
  const FollowToggleButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _FollowToggleButtonState createState() => _FollowToggleButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

class _FollowToggleButtonState extends State<FollowToggleButton> {
  late List<bool> _selections;
  late String _text;
  // late Color _color, _selectedColor, _fillColor, _highlightColor, _splashColor;

  @override
  void initState() {
    super.initState();
    _text = getButtonText(1, widget.product.id);

    _selections = [_text == 'Followed'];
  }

  String getButtonText(int userId, int productId) {
    final contain = demoUserFollowedProduct.where((element) =>
        element.userId == userId &&
        element.followedProductId.where((id) => id == productId).isNotEmpty);

    if (contain.isNotEmpty) {
      return 'Followed';
    }
    return 'Follow';
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(con_text).size;
    const buttonWidth = 120.0;
    return SizedBox(
      width: buttonWidth,
      child: LayoutBuilder(
        builder: (_, constraints) => ToggleButtons(
          isSelected: _selections,
          constraints: BoxConstraints.expand(
            width: constraints.maxWidth - 2,
            height: buttonWidth / 4,
          ),
          onPressed: (index) {
            setState(() {
              _selections[index] = !_selections[index];
              if (_selections[index]) {
                _text = 'Followed';
              } else {
                _text = 'Follow';
              }
            });
          },
          color: Theme.of(context).primaryColor,
          selectedColor: Colors.grey,
          fillColor: Colors.white,
          highlightColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).primaryColor,
          selectedBorderColor: Colors.grey,
          borderColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(23),
          children: [
            Text(_text),
          ],
        ),
      ),
    );
  }
}
