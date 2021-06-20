import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'post_details_no_items_section.dart';

class PostDetailsExpandedChildColumn<T> extends StatelessWidget {
  const PostDetailsExpandedChildColumn({
    Key? key,
    required this.generator,
    required this.expandChildCollapsedHint,
    required this.expandChildExpandedHint,
    required this.noItemsText,
    required this.itemBuilderWidget,
    required this.hintTextStyle,
    required this.arrowColor,
    this.toShowItemNumber = 1,
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
        : PostDetailsNoItemsSection(text: noItemsText);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<T>('items', items));
    properties.add(IntProperty('toShowItemNumber', toShowItemNumber));
    properties.add(DoubleProperty('spacingHeight', spacingHeight));
    properties.add(ObjectFlagProperty<Widget Function(int index)>.has(
        'generator', generator));
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

typedef CustomCallBack = Widget Function(Object);
