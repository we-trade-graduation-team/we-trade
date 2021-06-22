import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomAnimationLimiterForListView<T> extends StatelessWidget {
  const CustomAnimationLimiterForListView({
    Key? key,
    required this.list,
    required this.builder,
    required this.scrollDirection,
    required this.duration,
    this.addLastSeparator = false,
    this.separatorColor = Colors.transparent,
    this.verticalOffset = 50,
    this.separatorWidth,
    this.separatorHeight,
    this.endIndent,
    this.scrollPhysics,
  }) : super(key: key);

  final List<T> list;
  final Widget Function(BuildContext, T) builder;
  final Axis scrollDirection;
  final double? separatorWidth;
  final double? separatorHeight;
  final double? endIndent;
  final double? verticalOffset;
  final bool addLastSeparator;
  final ScrollPhysics? scrollPhysics;
  final Duration duration;
  final Color? separatorColor;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        scrollDirection: scrollDirection,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: scrollPhysics,
        itemCount: list.length + (addLastSeparator ? 1 : 0),
        itemBuilder: (_, index) {
          if (addLastSeparator && index == list.length) {
            return Container();
          }
          return KeepAliveListViewItem(
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: duration,
              child: SlideAnimation(
                verticalOffset: verticalOffset,
                child: FadeInAnimation(
                  child: builder(
                    context,
                    list[index],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return scrollDirection == Axis.horizontal
              ? VerticalDivider(
                  width: separatorWidth ?? 0,
                  color: separatorColor,
                  endIndent: endIndent,
                )
              : Divider(
                  height: separatorHeight ?? 0,
                  color: separatorColor,
                );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<T>('list', list));
    properties.add(
        ObjectFlagProperty<Widget Function(BuildContext p1, T p2)>.has(
            'builder', builder));
    properties.add(EnumProperty<Axis>('scrollDirection', scrollDirection));
    properties.add(DoubleProperty('separatorWidth', separatorWidth));
    properties.add(DoubleProperty('separatorHeight', separatorHeight));
    properties
        .add(DiagnosticsProperty<bool>('addLastSeparator', addLastSeparator));
    properties.add(
        DiagnosticsProperty<ScrollPhysics>('scrollPhysics', scrollPhysics));
    properties.add(DiagnosticsProperty<Duration>('duration', duration));
    properties.add(ColorProperty('separatorColor', separatorColor));
    properties.add(DoubleProperty('endIndent', endIndent));
    properties.add(DoubleProperty('verticalOffset', verticalOffset));
  }
}

class KeepAliveListViewItem extends StatefulWidget {
  const KeepAliveListViewItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAliveListViewItemState createState() => _KeepAliveListViewItemState();
}

class _KeepAliveListViewItemState extends State<KeepAliveListViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('wantKeepAlive', wantKeepAlive));
  }
}
