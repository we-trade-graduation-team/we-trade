import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../filterOverlay/filter_overlay.dart';

const ProductKind productKind= ProductKind(name: 'Flash Deal');
const List<ProductCard> list=[
  ProductCard(name: 'Product 1', image: 'image'),
  ProductCard(name: 'Product 2', image: 'image'),
  ProductCard(name: 'Product 3', image: 'image'),
  ProductCard(name: 'Product 4', image: 'image'),
  ProductCard(name: 'Product 5', image: 'image'),
  ProductCard(name: 'Product 6', image: 'image'),
];
class Category extends StatelessWidget {
  const Category({Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                  'Sản phẩm mới',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 100,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: list
                  ),
                ),
                Text(
                  productKind.name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 600,
                  child: GridView.count(
                    //scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: list,
                  ),
                )

              ],
            ),
          ),
        );
      }
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.name,
    required this.image
  }):super(key:key);

  final String image;
  final String name;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        width: 100,
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(image)
            ),
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('image', image));
    properties.add(StringProperty('name', name));
  }
}
  

