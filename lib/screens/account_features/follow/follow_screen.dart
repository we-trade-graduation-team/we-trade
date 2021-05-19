import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/assets_paths/shared_assets_root.dart';
import '../../../configs/constants/color.dart';
import '../account/account_screen.dart';
import '../account/local_widgets/getter.dart';
import '../utils.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/follow';

  @override
  _FollowScreenState createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  final referenceDatabase = AccountScreen.localRefDatabase;
  final String userID = AccountScreen.localUserID;

  late Map<String, dynamic>? _user;
  bool _isLoaded = false;
  int timeOut = 10;

  @override
  void initState() {
    super.initState();

    try {
      referenceDatabase
          .collection('users')
          .doc(userID)
          .get()
          .then((documentSnapshot) {
        _user = documentSnapshot.data();

        if (_user == null) {
          showMyNotificationDialog(
              context: context,
              title: 'Lỗi',
              content: 'Không có dữ liệu! Vui lòng thử lại.',
              handleFunction: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
        } else {
          setState(() {
            _isLoaded = true;
          });
        }
      }).timeout(Duration(seconds: timeOut));
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print('Lỗi: $e');
      showMyNotificationDialog(
          context: context,
          title: 'Lỗi',
          content: 'Tải dữ liệu không thành công. Vui lòng thử lại!',
          handleFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final screen = routeArguments['screenArgument'] as FollowScreenArguments;
    var usersRender = <dynamic>[];
    var followingUsers = <dynamic>[];

    if (_isLoaded) {
      usersRender = screen.screenName == Follow_Screen_Name.follower
          ? _user!['followers'] as List
          : _user!['following'] as List;
      followingUsers = _user!['following'] as List;
    }

    Widget buildFollowButton(String idValue) {
      return ElevatedButton(
        onPressed: () {
          followingUsers.add(idValue);
          try {
            referenceDatabase
                .collection('users')
                .doc(userID)
                .update({'following': followingUsers}).then((value) {
              setState(() {
                _user!['following'] = followingUsers;
                _isLoaded = true;
              });
            }).timeout(Duration(seconds: timeOut));
          } on FirebaseException catch (error) {
            // ignore: avoid_print
            print('Lỗi khi follow: $error');
          }
        },
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          elevation: 4,
          onPrimary: kPrimaryLightColor,
        ),
        child: const Text('   Theo dõi  '),
      );
    }

    Widget buildUnfollowButton(String idValue) {
      return OutlinedButton(
        onPressed: () async {
          await showMyConfirmationDialog(
              context: context,
              title: 'Thông báo',
              content: 'Bạn có chắc muốn bỏ theo dõi người dùng này không?',
              onConfirmFunction: () {
                Navigator.of(context).pop();
                setState(() {
                  _isLoaded = false;
                });

                followingUsers.remove(idValue);
                try {
                  referenceDatabase
                      .collection('users')
                      .doc(userID)
                      .update({'following': followingUsers}).then((value) {
                    setState(() {
                      _user!['following'] = followingUsers;
                      _isLoaded = true;
                    });
                  }).timeout(Duration(seconds: timeOut));
                } on FirebaseException catch (error) {
                  // ignore: avoid_print
                  print('Lỗi khi unfollow: $error');
                }
              },
              onCancelFunction: () {
                Navigator.of(context).pop();
              });
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: kPrimaryColor,
            width: 1.5,
          ),
        ),
        child: const Text(
          'Bỏ theo dõi',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: screen.screenName == Follow_Screen_Name.follower
            ? const Text('Theo dõi bởi')
            : const Text('Đang theo dõi'),
      ),
      body: _isLoaded
          ? (usersRender.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Image.asset(
                        '$chatScreenAvaFolder/user.png',
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: GetUserName(
                        key: ValueKey(usersRender[index].toString()),
                        documentId: usersRender[index].toString(),
                        isStream: false,
                      ),
                      trailing: screen.screenName ==
                              Follow_Screen_Name.following
                          ? buildUnfollowButton(usersRender[index] as String)
                          : (followingUsers.contains(usersRender[index])
                              ? buildUnfollowButton(
                                  usersRender[index] as String)
                              : buildFollowButton(
                                  usersRender[index] as String)),
                    ),
                  ),
                  itemCount: usersRender.length,
                )
              : const Center(
                  child: Text(
                    'Chưa có dữ liệu.',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black45,
                    ),
                  ),
                ))
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DocumentReference<Map<String, dynamic>>>(
        'referenceDatabase', referenceDatabase));
    properties.add(IntProperty('timeOut', timeOut));
    properties.add(StringProperty('userID', userID));
  }
}

enum Follow_Screen_Name {
  following,
  follower,
}

class FollowScreenArguments {
  FollowScreenArguments({required this.screenName});
  final Follow_Screen_Name screenName;
}
