import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    Key? key,
    required this.items,
    required this.enableInfiniteScroll,
    required this.width,
    this.selectedItem = 0,
    this.autoPlay = false,
    this.dotColor,
    this.dotActiveColor,
    this.height,
  }) : super(key: key);

  final List<Widget> items;
  final int selectedItem;
  final double? height;
  final double width;
  final bool autoPlay, enableInfiniteScroll;
  final Color? dotColor, dotActiveColor;

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('selectedItem', selectedItem));
    properties.add(DoubleProperty('height', height));
    properties.add(DiagnosticsProperty<bool>(
        'enableInfiniteScroll', enableInfiniteScroll));
    properties.add(DiagnosticsProperty<bool>('autoPlay', autoPlay));
    properties.add(DoubleProperty('width', width));
    properties.add(ColorProperty('dotActiveColor', dotActiveColor));
    properties.add(ColorProperty('dotColor', dotColor));
  }
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CarouselSlider(
              items: widget.items,
              options: CarouselOptions(
                height: widget.height,
                autoPlay: widget.autoPlay,
                onPageChanged: (index, _) => onPageChanged(index),
                enableInfiniteScroll: widget.enableInfiniteScroll,
                autoPlayCurve: Curves.easeIn,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                viewportFraction: 1,
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.01,
            child: DotsIndicator(
              // onTap: (position) {
              //   setState(() => _activeIndex = position.toInt());
              //   onPageChanged(position.toInt());
              // },
              dotsCount: widget.items.length,
              position: _activeIndex.toDouble(),
              decorator: DotsDecorator(
                color: widget.dotColor ?? Colors.grey, // Inactive color
                activeColor: widget.dotActiveColor ?? Colors.lightBlue,
                activeSize: const Size(18, 9),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _activeIndex = index;
    });
  }
}
