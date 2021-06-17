import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavouriteToggleButton extends StatefulWidget {
  const FavouriteToggleButton({
    Key? key,
    required this.isFavourite,
  }) : super(key: key);

  final bool isFavourite;

  @override
  _FavouriteToggleButtonState createState() => _FavouriteToggleButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isFavourite', isFavourite));
  }
}

class _FavouriteToggleButtonState extends State<FavouriteToggleButton> {
  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = [widget.isFavourite];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color(0xFFDBDEE4).withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: ToggleButtons(
        isSelected: _selections,
        onPressed: (index) {
          setState(() {
            _selections[index] = !_selections[index];
            // isFavourite = !widget.isFavourite;
          });
        },
        selectedColor: const Color(0xFFEB5757),
        color: const Color(0xFFBFC1C7),
        fillColor: const Color(0xFFFFE6E6),
        highlightColor: const Color(0xFFFFD9E0),
        splashColor: Theme.of(context).primaryColor,
        renderBorder: false,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        children: const [
          Icon(EvaIcons.heart),
        ],
      ),
    );
  }
}
