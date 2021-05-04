import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../models/shared_models/product_model.dart';
import '../../../widgets/product_card.dart';
import '../filter_overlay/filter_overlay.dart';
import '../home_screen/local_widgets/home_screen_search_bar.dart';
import '../home_screen/local_widgets/icon_button_with_counter.dart';
import '../notification/notification_screen.dart';
import '../shared_widgets/horizontal_scroll_product_listview.dart';

const ProductKind productKind = ProductKind(name: 'Flash Deal');

class CategoryKind extends StatelessWidget {
  const CategoryKind({Key? key}) : super(key: key);

  static String routeName = '/categories';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height*0.05,),
            Row(
              children: <Widget>[
                SizedBox(width: size.width*0.05,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                    child: const HomeScreenSearchBar()
                ),
                SizedBox(width: size.width*0.05,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: IconButtonWithCounter(
                      iconColor: Colors.grey,
                      icon: 'bell',
                      numOfItems: 4,
                      press: () => pushNewScreenWithRouteSettings<void>(
                        context,
                        screen: NotificationScreen(),
                        settings: const RouteSettings(name: '/notificationScreen'),
                        withNavBar: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: LayoutBuilder(builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    /*child: SectionTitle(
                            title: 'Sản phẩm mới',
                            press: () {},
                          ),*/
                  ),
                  SizedBox(height: size.width * 0.05),
                  HorizontalScrollProductListView(items: demoProducts),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    /*child: SectionTitle(
                            title: productKind.name,
                            press: () {},
                          ),*/
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
                      //padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      crossAxisSpacing: size.width * 0.05,
                      mainAxisSpacing: size.height * 0.01,
                      children: [
                        ...List.generate(
                          recommendedProducts.length,
                              (index) =>
                              ProductCard(product: recommendedProducts[index]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
