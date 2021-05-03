import 'package:flutter/material.dart';
import '../../../configs/constants/color.dart';
import '../../../models/shared_models/product_model.dart';
import 'local_widgets/body.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kScreenBackgroundColor,
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  ProductDetailsArguments({required this.product});

  final Product product;
}
