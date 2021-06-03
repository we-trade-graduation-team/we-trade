import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../models/cloud_firestore/special_offer_card/special_offer_card.dart';

class HomeScreenSpecialOfferCard extends StatelessWidget {
  const HomeScreenSpecialOfferCard({
    Key? key,
    required this.specialOfferCard,
    required this.press,
    required this.cardHeight,
  }) : super(key: key);

  final SpecialOfferCard specialOfferCard;
  final VoidCallback press;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: cardHeight,
        child: AspectRatio(
          aspectRatio: 25 / 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    specialOfferCard.photoUrl,
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
                          text: '${specialOfferCard.category}\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(height: size.height * 0.03),
                        ),
                        TextSpan(
                          text: '${specialOfferCard.numberOfBrands} Brands',
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
    properties.add(ObjectFlagProperty<VoidCallback>.has('press', press));
    properties.add(DiagnosticsProperty<SpecialOfferCard>(
        'specialOfferCard', specialOfferCard));
    properties.add(DoubleProperty('cardHeight', cardHeight));
  }
}
