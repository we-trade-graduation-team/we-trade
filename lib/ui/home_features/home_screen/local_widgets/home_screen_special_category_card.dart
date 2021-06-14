import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/cloud_firestore/special_category_card/special_category_card.dart';

class HomeScreenSpecialCategoryCard extends StatelessWidget {
  const HomeScreenSpecialCategoryCard({
    Key? key,
    required this.specialCategoryCard,
    required this.cardHeight,
  }) : super(key: key);

  final SpecialCategoryCard specialCategoryCard;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SizedBox(
      height: cardHeight,
      child: AspectRatio(
        aspectRatio: 25 / 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  specialCategoryCard.photoUrl,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: '${specialCategoryCard.category}\n',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // WidgetSpan(
                      //   child: SizedBox(height: size.height * 0.03),
                      // ),
                      // TextSpan(
                      //   text: '${specialOfferCard.numberOfBra3ds} Brands',
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('cardHeight', cardHeight));
    properties.add(DiagnosticsProperty<SpecialCategoryCard>(
        'specialCategoryCard', specialCategoryCard));
  }
}
