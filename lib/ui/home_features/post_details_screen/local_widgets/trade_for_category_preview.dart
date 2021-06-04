import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        color: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: size.height * 0.013,
        ),
        child: Text(
          tradeForCategory,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
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
