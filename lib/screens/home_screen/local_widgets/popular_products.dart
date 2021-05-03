import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../widgets/horizontal_scroll_product_listview.dart';
import 'home_section_with_list_view_child.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popularProducts =
        demoProducts.where((product) => product.isPopular).toList();

    return HomeSectionWithListViewChild(
      title: 'Popular Products',
      press: () {},
      child: HorizontalScrollProductListView(items: popularProducts),
    );
  }
}
