import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/color.dart';
import '../../../configs/constants/keys.dart';
import '../../../models/product_model.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
  }
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: size.width,
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: widget.product.id.toString(),
                  child: Image.network(widget.product.images[selectedImage]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    widget.product.images.length, buildSmallProductPreview),
              ],
            )
          ],
        ),

        // SizedBox(
        //   width: size.width * 0.6,
        //   child: Hero(
        //     tag: widget.product.id.toString(),
        //     child: Image.network(
        //       widget.product.images[selectedImage],
        //       fit: BoxFit.cover,
        //       // height: double.infinity,
        //       // width: double.infinity,
        //     ),
        //   ),
        // ),
        // SizedBox(height: size.height * 0.02),
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: size.height * 0.06,
        width: size.width * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.product.images[index]),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('selectedImage', selectedImage));
  }
}
