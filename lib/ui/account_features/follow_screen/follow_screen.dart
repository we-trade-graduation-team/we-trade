import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../account_screen/local_widgets/getter.dart';
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
  final referenceDatabase = FirebaseFirestore.instance;
  final String userID = FirebaseAuth.instance.currentUser!.uid;

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
    final width = MediaQuery.of(context).size.width;
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
          primary: Theme.of(context).primaryColor,
          elevation: 4,
          onPrimary: AppColors.kPrimaryLightColor,
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
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        child: Text(
          'Bỏ theo dõi',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        FutureBuilder<DocumentSnapshot>(
                            future: referenceDatabase
                                .collection('users')
                                .doc(usersRender[index].toString())
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final user = snapshot.data!;
                                return CircleAvatar(
                                  backgroundColor: Colors.black26,
                                  backgroundImage: NetworkImage(
                                    user['avatarUrl'].toString(),
                                  ),
                                  radius: width * 0.085,
                                );
                              }

                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black45,
                              ));
                            }),
                        const SizedBox(width: 15),
                        Expanded(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.kTextColor,
                                fontWeight: FontWeight.w500),
                            child: GetUserName(
                              key: ValueKey(usersRender[index].toString()),
                              documentId: usersRender[index].toString(),
                              isStream: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        if (screen.screenName == Follow_Screen_Name.following)
                          buildUnfollowButton(usersRender[index] as String)
                        else
                          followingUsers.contains(usersRender[index])
                              ? buildUnfollowButton(
                                  usersRender[index] as String)
                              : buildFollowButton(usersRender[index] as String),
                      ],
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
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('timeOut', timeOut));
    properties.add(StringProperty('userID', userID));
    properties.add(DiagnosticsProperty<FirebaseFirestore>(
        'referenceDatabase', referenceDatabase));
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
