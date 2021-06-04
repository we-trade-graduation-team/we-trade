import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImageZoomScreen extends StatelessWidget {
  const ImageZoomScreen({
    Key? key,
    required this.tittle,
    required this.photoURL,
  }) : super(key: key);

  final String tittle;
  final String photoURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tittle),
      ),
      body: PinchZoom(
        image: Image.network(photoURL),
        zoomedBackgroundColor: Colors.black.withOpacity(0.5),
        resetDuration: const Duration(milliseconds: 2000),
        maxScale: 3.5,
        onZoomStart: () {},
        onZoomEnd: () {},
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('tittle', tittle));
    properties.add(StringProperty('photoURL', photoURL));
  }
}
