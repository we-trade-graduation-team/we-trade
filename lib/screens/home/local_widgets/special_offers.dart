import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SectionTitle(
            title: 'Special for you',
            press: () {},
          ),
        ),
        SizedBox(height: size.width * 0.05),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                // image: imageBanner2Image,
                image:
                    'https://images.unsplash.com/photo-1523371683773-affcb4a2e39e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=701&q=80',
                category: 'Smartphone',
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                // image: imageBanner3Image,
                image:
                    'https://images.unsplash.com/photo-1515343480029-43cdfe6b6aae?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1100&q=80',
                category: 'Laptop',
                numOfBrands: 24,
                press: () {},
              ),
              SpecialOfferCard(
                // image: imageBanner3Image,
                image:
                    'https://images.unsplash.com/photo-1524805444758-089113d48a6d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
                category: 'Watch',
                numOfBrands: 14,
                press: () {},
              ),
              SizedBox(width: size.width * 0.05),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.05),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: size.width * 0.65,
          height: size.height * 0.12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity(0.4),
                        const Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.065,
                    vertical: size.height * 0.02,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: '$category\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '$numOfBrands Brands',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('image', image));
    properties.add(IntProperty('numOfBrands', numOfBrands));
    properties.add(ObjectFlagProperty<GestureTapCallback>.has('press', press));
    properties.add(StringProperty('category', category));
  }
}
