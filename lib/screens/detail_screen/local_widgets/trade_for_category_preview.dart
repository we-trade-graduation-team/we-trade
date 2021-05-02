import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';

class TradeForCategoryPreview extends StatelessWidget {
  const TradeForCategoryPreview({
    Key? key,
    required this.tradeForCategory,
  }) : super(key: key);

  final String tradeForCategory;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: size.height * 0.043,
        color: kPrimaryLightColor,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: size.height * 0.013,
        ),
        child: Text(
          tradeForCategory,
          style: const TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tradeForCategory', tradeForCategory));
  }
}
