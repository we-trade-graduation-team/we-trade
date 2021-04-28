import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final Widget dropdownLabel;
  // ignore: diagnostic_describe_all_properties
  final String labeledKey;
  final List<DropdownItem> dropdownItems;

  // ignore: sort_constructors_first
  const CustomDropdown(
      {Key? key,
      required this.labeledKey,
      required this.dropdownLabel,
      required this.dropdownItems})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

late OverlayEntry globalFloatingDropdown;
bool globalIsDropdowOpened = false;

// ignore: prefer_mixin
class _CustomDropdownState extends State<CustomDropdown> with RouteAware {
  // ignore: diagnostic_describe_all_properties
  GlobalKey actionKey = GlobalKey();
  // ignore: diagnostic_describe_all_properties
  bool isDropdowOpened = false;

  // ignore: diagnostic_describe_all_properties
  late double height, width, xPosition, yPosition;
  // ignore: diagnostic_describe_all_properties
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
}

class Dropdown extends StatelessWidget {
  // ignore: diagnostic_describe_all_properties
  final double itemHeight;
  final List<DropdownItem> dropdownItems;

  // ignore: sort_constructors_first
  const Dropdown(
      {Key? key, required this.itemHeight, required this.dropdownItems})
      : super(key: key);

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
}

class DropdownItem extends StatelessWidget {
  // ignore: diagnostic_describe_all_properties
  final String text;
  // ignore: diagnostic_describe_all_properties
  final IconData iconData;
  // ignore: diagnostic_describe_all_properties
  final bool isSelected;
  // ignore: diagnostic_describe_all_properties
  final Function handleFunction;

  // ignore: sort_constructors_first
  const DropdownItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.isSelected,
    required this.handleFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: unnecessary_lambdas
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
}
