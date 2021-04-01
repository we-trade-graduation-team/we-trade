import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/screens/filterOverlay/filter_overlay.dart';

const ProductKind productKind= ProductKind(name: 'Flash Deal');
const List<ProductCard> list=[
  const ProductCard(name: 'Product 1', image: 'image'),
  const ProductCard(name: 'Product 2', image: 'image'),
  const ProductCard(name: 'Product 3', image: 'image'),
  const ProductCard(name: 'Product 4', image: 'image'),
  const ProductCard(name: 'Product 5', image: 'image'),
  const ProductCard(name: 'Product 6', image: 'image'),
];
class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Sản phẩm mới',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 100.0,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: list
                  ),
                ),
                Text(
                  productKind.name,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  height: 600.0,
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
  final String image;
  final String name;
  
  const ProductCard({
    required this.name,
    required this.image
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 100.0,
        width: 100.0,
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(image)
            ),
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
  

