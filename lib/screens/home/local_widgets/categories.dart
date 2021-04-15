import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../configs/constants/color.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = <Map<String, String>>[
      {'icon': 'lightningBolt', 'text': 'Flash Deal'},
      {'icon': 'television', 'text': 'Electronic devices'},
      {'icon': 'laptop', 'text': 'Laptop'},
      {'icon': 'mobilePhone', 'text': 'Mobile'},
      {'icon': 'warehouse', 'text': 'Household devices'},
      {'icon': 'child', 'text': 'Toy'},
      {'icon': 'stopwatch', 'text': 'Watch'},
      {'icon': 'book', 'text': 'Book'},
      {'icon': 'bone', 'text': 'Pet'},
      {'icon': 'dotCircle', 'text': 'More'},
    ];

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
        bottom: size.height * 0.04,
      ),
      child: Center(
        child: Wrap(
          spacing: 12, // gap between adjacent chips
          runSpacing: 12, // gap between lines
          children: List.generate(
            categories.length,
            (index) => CategoryCard(
              icon: categories[index]['icon']!,
              text: categories[index]['text']!,
              press: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: size.width * 0.15,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(size.width * 0.04),
              height: size.width * 0.15,
              width: size.width * 0.15,
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              // child: SvgPicture.asset(
              //   icon,
              //   color: kPrimaryColor,
              // ),
              child: Icon(
                LineIcons.values[icon],
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: kTextLightColor,
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
    properties.add(StringProperty('icon', icon));
    properties.add(StringProperty('text', text));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
  }
}
