import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {Key? key,
      required this.labeledKey,
      required this.dropdownLabel,
      required this.dropdownItems})
      : super(key: key);

  final Widget dropdownLabel;

  final String labeledKey;
  final List<DropdownItem> dropdownItems;

  @override
  _CustomDropdownState createState() => _CustomDropdownState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('labeledKey', labeledKey));
  }
}

late OverlayEntry globalFloatingDropdown;
bool globalIsDropdowOpened = false;

mixin RouteAware {}

class _CustomDropdownState extends State<CustomDropdown> with RouteAware {
  GlobalKey actionKey = GlobalKey();

  bool isDropdowOpened = false;

  late double height, width, xPosition, yPosition;

  late OverlayEntry floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.labeledKey);
    super.initState();
  }

  //  void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // routeObserver is the global variable we created before

  //   routeObserver.subscribe(this,  ModalRoute.of(context) as PageRoute);
  // }

  void findDropdownData() {
    final renderBox = actionKey.currentContext!.findRenderObject() as RenderBox;
    // height = renderBox.size.height;
    // width = renderBox.size.width;
    height = 40;
    width = MediaQuery.of(context).size.width * 0.35;
    final offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        // left: xPosition - width / 1.5,
        right: 20,
        width: width,
        top: yPosition + 25,
        height: widget.dropdownItems.length * height,
        child: Dropdown(
          itemHeight: height,
          dropdownItems: widget.dropdownItems,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (globalIsDropdowOpened) {
            floatingDropdown.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            globalFloatingDropdown = floatingDropdown;
            Overlay.of(context)!.insert(floatingDropdown);
          }

          // isDropdowOpened = !isDropdowOpened;
          globalIsDropdowOpened = !globalIsDropdowOpened;
        });
      },
      child: Container(
        child: widget.dropdownLabel,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>(
        'actionKey', actionKey));
    properties
        .add(DiagnosticsProperty<bool>('isDropdowOpened', isDropdowOpened));
    properties.add(DoubleProperty('height', height));
    properties.add(DoubleProperty('width', width));
    properties.add(DoubleProperty('xPosition', xPosition));
    properties.add(DoubleProperty('yPosition', yPosition));
    properties.add(DiagnosticsProperty<OverlayEntry>(
        'floatingDropdown', floatingDropdown));
  }
}

class Dropdown extends StatelessWidget {
  const Dropdown(
      {Key? key, required this.itemHeight, required this.dropdownItems})
      : super(key: key);

  final double itemHeight;
  final List<DropdownItem> dropdownItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 25,
          child: Container(
            height: dropdownItems.length * itemHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...dropdownItems,
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('itemHeight', itemHeight));
  }
}

class DropdownItem extends StatelessWidget {
  const DropdownItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.isSelected,
    required this.handleFunction,
  }) : super(key: key);

  final String text;

  final IconData iconData;

  final bool isSelected;

  final Function handleFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalFloatingDropdown.remove();
        globalIsDropdowOpened = !globalIsDropdowOpened;

        handleFunction();
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.24,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const Spacer(),
            Icon(iconData),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
    properties.add(DiagnosticsProperty<IconData>('iconData', iconData));
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
    properties
        .add(DiagnosticsProperty<Function>('handleFunction', handleFunction));
  }
}
