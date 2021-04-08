import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_trade/models/product_model.dart';
import 'package:we_trade/screens/home/local_widgets/home_header.dart';
import 'package:we_trade/screens/home/local_widgets/section_title.dart';
import 'package:we_trade/widgets/custom_bottom_navigation_bar.dart';
import 'package:we_trade/widgets/product_card.dart';
import '../filterOverlay/filter_overlay.dart';

const ProductKind productKind= ProductKind(name: 'Flash Deal');
class Category extends StatelessWidget {
  const Category({Key? key}):super(key:key);

  static String routeName = '/categories';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 20),
        child: const HomeHeader(),
      ),
      body: LayoutBuilder(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: SectionTitle(
                      title: 'Sản phẩm mới',
                      press: () {},
                    ),
                  ),
                  SizedBox(height: size.width * 0.05),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: [...List.generate(
                          demoProducts.length,
                              (index) {
                                if (demoProducts[index].isPopular) {
                                  return ProductCard(product: demoProducts[index]);
                                }

                                return const SizedBox
                                  .shrink(); // here by default width and height is 0
                              },
                          ),
                          SizedBox(width: size.width * 0.05),
                        ],
                    ),

                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: SectionTitle(
                      title: productKind.name,
                      press: () {},
                    ),
                  ),
                  SizedBox(height: size.width * 0.05),
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.05),
                    child: GridView.count(
                      childAspectRatio: size.height / 1090,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      crossAxisCount: 2,
                      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      // crossAxisSpacing: 10,
                      mainAxisSpacing: size.height * 0.02,
                      children: [
                        ...List.generate(
                          recommendedProducts.length,
                              (index) => ProductCard(product: recommendedProducts[index]),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}