import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainTabOtherUserProfile extends StatefulWidget {
  const MainTabOtherUserProfile({Key? key}) : super(key: key);

  @override
  _MainTabOtherUserProfileState createState() =>
      _MainTabOtherUserProfileState();
}

class _MainTabOtherUserProfileState extends State<MainTabOtherUserProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final tabData = ['ABOUT', 'POSTS', 'REVIEW'];

  @override
  void initState() {
    _tabController = TabController(length: tabData.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // /// some widget above tab header
        // Container(
        //   height: 100,
        //   alignment: Alignment.center,
        //   child: Text('Header'),
        // ),

        /// tab header
        Container(
          height: 40,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 0.5,
              ),
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 0.5,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: [
              ...tabData.map(
                (item) => Tab(
                  child: Text(item),
                ),
              ),
            ],
          ),
        ),

        /// tab content
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          // transitionBuilder: (Widget child, Animation<double> animation) {
          //   var direction = _tabController.index > _tabController.previousIndex
          //       ? AxisDirection.left
          //       : AxisDirection.right;
          //   return SlideTransitionX(
          //     child: child,
          //     direction: direction,
          //     position: animation,
          //   );
          // },
          child: getTabContent(_tabController.index),
        ),
      ],
    ));
  }

  Widget getTabContent(int index) {
    switch (index) {
      case 0:
        return tabContent('About', 5);
      case 1:
        return tabContent('Post', 10);
      default:
        return tabContent('Review', 15);
    }
  }

  Widget tabContent(
    String title,
    int length,
  ) {
    return Column(
      key: ValueKey<int>(length),
      children: [
        ...List.generate(
          length,
          (index) => ListTile(
            title: Text('$title item $index'),
            trailing: const Icon(Icons.access_alarm),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<String>('tabData', tabData));
  }
}

/// code copied from https://book.flutterchina.club/chapter9/animated_switcher.html
// class SlideTransitionX extends AnimatedWidget {
//   SlideTransitionX({
//     Key key,
//     @required Animation<double> position,
//     this.transformHitTests = true,
//     this.direction = AxisDirection.down,
//     this.child,
//   })  : assert(position != null),
//         super(key: key, listenable: position) {
//     // 偏移在内部处理
//     switch (direction) {
//       case AxisDirection.up:
//         _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
//         break;
//       case AxisDirection.right:
//         _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
//         break;
//       case AxisDirection.down:
//         _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
//         break;
//       case AxisDirection.left:
//         _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
//         break;
//     }
//   }

//   Animation<double> get position => listenable;

//   final bool transformHitTests;

//   final Widget child;

//   //退场（出）方向
//   final AxisDirection direction;

//   Tween<Offset> _tween;

//   @override
//   Widget build(BuildContext context) {
//     Offset offset = _tween.evaluate(position);
//     if (position.status == AnimationStatus.reverse) {
//       switch (direction) {
//         case AxisDirection.up:
//           offset = Offset(offset.dx, -offset.dy);
//           break;
//         case AxisDirection.right:
//           offset = Offset(-offset.dx, offset.dy);
//           break;
//         case AxisDirection.down:
//           offset = Offset(offset.dx, -offset.dy);
//           break;
//         case AxisDirection.left:
//           offset = Offset(-offset.dx, offset.dy);
//           break;
//       }
//     }
//     return FractionalTranslation(
//       translation: offset,
//       transformHitTests: transformHitTests,
//       child: child,
//     );
//   }
// }
