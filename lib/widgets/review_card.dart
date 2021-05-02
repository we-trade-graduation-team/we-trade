import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../configs/constants/color.dart';
import '../models/review/temp_class.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 3, 15, 3),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        //color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: kTextLightV2Color,
            width: 0.2,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: CircleAvatar(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(review.user.image),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(review.user.name),
                  ),
                  RatingBar.builder(
                    initialRating: review.stars,
                    allowHalfRating: true,
                    //itemCount: 5,
                    glowRadius: 10,
                    glowColor: Colors.yellow[100],
                    itemSize: 20,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    //onRatingUpdate: print,
                    ignoreGestures: true,
                    onRatingUpdate: (value) {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    review.product.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 3,
                child: Text(review.comment),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Text(
                review.dateTime.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          getWidgetReplie(review.replie),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Review>('review', review));
  }

  Widget getWidgetReplie(String? replie) {
    if (replie == null) {
      return Container();
    }
    return Container(
      decoration: BoxDecoration(
        color: kBackGroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: 'Phản hồi',
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: '\n',
          hintStyle: TextStyle(height: 2),
          labelStyle: TextStyle(
            color: kRiviewTextLabel,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        initialValue: replie,
        maxLines: null,
        style: const TextStyle(fontSize: 14),
        enabled: false,
      ),
    );
  }
}