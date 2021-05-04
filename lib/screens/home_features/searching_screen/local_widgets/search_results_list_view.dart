import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../configs/constants/color.dart';
import '../../../../models/shared_models/product_model.dart';
import '../../../../widgets/product_card.dart';

class SearchResultsListView extends StatefulWidget {
  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  final String? searchTerm;

  @override
  _SearchResultsListViewState createState() => _SearchResultsListViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('searchTerm', searchTerm));
  }
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  late int initialIndex;
  late List<Product> toShowProducts;

  @override
  void initState() {
    super.initState();
    initialIndex = 0;
    toShowProducts = [];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    setState(() {
      toShowProducts = [...getResult(widget.searchTerm!)];
    });

    if (toShowProducts.isEmpty) {
      return const Center(child: Text('No result'));
    }

    final fsb = FloatingSearchBar.of(context)!.newValue;
    final size = MediaQuery.of(context).size;
    final sortList = ['Featured', 'Distance', 'Price'];

    return Padding(
      padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ToggleSwitch(
              minWidth: size.width * (1 - 0.05),
              initialLabelIndex: initialIndex,
              activeBgColor: kPrimaryColor,
              inactiveBgColor: kTextLightColor.withOpacity(0.9),
              inactiveFgColor: Colors.white,
              labels: sortList,
              onToggle: (index) {
                setState(() {
                  initialIndex = index;
                });
                sortResult(toShowProducts, index);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  children: [
                    Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 15,
                        children: toShowProducts
                            .map(
                              (product) => ProductCard(product: product),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product> getResult(String searchTerm) {
    final findProducts = demoProducts
        .where((element) =>
            element.title.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
    if (findProducts.isNotEmpty) {
      sortResult(findProducts, initialIndex);
    }
    return findProducts;
  }

  void sortResult(List<Product> exampleProducts, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        setState(() {
          exampleProducts.sort((a, b) => a.price.compareTo(b.price));
        });
        break;
      default:
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('searchTerm', widget.searchTerm));
    properties.add(IterableProperty<Product>('toShowProducts', toShowProducts));
    properties.add(IntProperty('initialIndex', initialIndex));
  }
}
