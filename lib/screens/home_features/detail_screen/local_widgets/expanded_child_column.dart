import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../configs/constants/color.dart';

import 'no_items_section.dart';

class ExpandedChildColumn<T> extends StatelessWidget {
  const ExpandedChildColumn({
    Key? key,
    required this.generator,
    // required this.itemBuilder,
    required this.expandChildCollapsedHint,
    required this.expandChildExpandedHint,
    required this.noItemsText,
    required this.itemBuilderWidget,
    this.toShowItemNumber = 1,
    this.hintTextStyle = const TextStyle(color: kPrimaryColor),
    this.arrowColor = kPrimaryColor,
    this.arrowSize = 24,
    this.capitalArrowText = false,
    this.expandArrowStyle = ExpandArrowStyle.both,
    this.dividerColor = Colors.transparent,
    this.items,
    this.type,
    this.spacingHeight,
  }) : super(key: key);

  final T? type;
  final List<T>? items;
  final Widget Function(int index) generator;
  // final Widget Function(BuildContext context, int index) itemBuilder;
  final int toShowItemNumber;
  final double? spacingHeight;
  final String expandChildCollapsedHint, expandChildExpandedHint, noItemsText;
  final TextStyle? hintTextStyle;
  final Color? arrowColor, dividerColor;
  final double arrowSize;
  final bool capitalArrowText;
  final ExpandArrowStyle expandArrowStyle;
  final CustomCallBack itemBuilderWidget;

  @override
  Widget build(BuildContext context) {
    return (items != null && items!.isNotEmpty)
        ? Column(
            children: [
              ...List.generate(
                toShowItemNumber,
                generator,
              ),
              SizedBox(height: spacingHeight),
              if (items!.length > toShowItemNumber)
                ExpandChild(
                  collapsedHint: expandChildCollapsedHint,
                  expandedHint: expandChildExpandedHint,
                  hintTextStyle: hintTextStyle,
                  arrowColor: arrowColor,
                  arrowSize: arrowSize,
                  expandArrowStyle: expandArrowStyle,
                  capitalArrowtext: capitalArrowText,
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) => itemBuilderWidget(
                            items![index + toShowItemNumber]!),
                        separatorBuilder: (_, __) => Divider(
                          height: spacingHeight,
                          color: dividerColor,
                        ),
                        itemCount: items!.length - toShowItemNumber,
                      ),
                    ],
                  ),
                ),
            ],
          )
        : NoItemsSection(text: noItemsText);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<T>('items', items));
    properties.add(IntProperty('toShowItemNumber', toShowItemNumber));
    properties.add(DoubleProperty('spacingHeight', spacingHeight));
    properties.add(ObjectFlagProperty<Widget Function(int index)>.has(
        'generator', generator));
    // properties.add(ObjectFlagProperty<
    //     Widget Function(
    //         BuildContext context, int index)>.has('itemBuilder', itemBuilder));
    properties.add(
        StringProperty('expandChildCollapsedHint', expandChildCollapsedHint));
    properties.add(
        StringProperty('expandChildExpandedHint', expandChildExpandedHint));
    properties
        .add(DiagnosticsProperty<bool>('capitalArrowText', capitalArrowText));
    properties.add(DoubleProperty('arrowSize', arrowSize));
    properties.add(ColorProperty('dividerColor', dividerColor));
    properties.add(
        EnumProperty<ExpandArrowStyle>('expandArrowStyle', expandArrowStyle));
    properties.add(ColorProperty('arrowColor', arrowColor));
    properties.add(StringProperty('noItemsText', noItemsText));
    properties
        .add(DiagnosticsProperty<TextStyle?>('hintTextStyle', hintTextStyle));
    properties.add(ObjectFlagProperty<CustomCallBack>.has(
        'itemBuilderWidget', itemBuilderWidget));
    properties.add(DiagnosticsProperty<T?>('type', type));
  }
}

typedef CustomCallBack = Widget Function(Object item);
