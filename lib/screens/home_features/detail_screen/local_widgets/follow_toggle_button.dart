import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';
import '../../../../models/detail_screen/user_followed_product.dart';
import '../../../../models/shared_models/product_model.dart';

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
  late String text;
  late Color color, selectedColor, fillColor, highlightColor, splashColor;

  @override
  void initState() {
    super.initState();
    text = getButtonText(1, widget.product.id);

    _selections = [text == 'Followed'];
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
    // final size = MediaQuery.of(context).size;
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
                text = 'Followed';
              } else {
                text = 'Follow';
              }
            });
          },
          color: kPrimaryColor,
          selectedColor: Colors.grey,
          fillColor: Colors.white,
          highlightColor: kPrimaryColor,
          splashColor: kPrimaryColor,
          selectedBorderColor: Colors.grey,
          borderColor: kPrimaryColor,
          borderRadius: BorderRadius.circular(23),
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(ColorProperty('fillColor', fillColor));
    properties.add(ColorProperty('selectedColor', selectedColor));
    properties.add(ColorProperty('highlightColor', highlightColor));
    properties.add(ColorProperty('color', color));
    properties.add(ColorProperty('splashColor', splashColor));
  }
}
