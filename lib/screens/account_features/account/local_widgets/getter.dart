import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../follow/follow_screen.dart';
import '../account_screen.dart';

class GetUserName extends StatelessWidget {
  const GetUserName(
      {Key? key, required this.documentId, required this.isStream})
      : super(key: key);
  final String documentId;
  final bool isStream;

  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        AccountScreen.localRefDatabase.collection('users');

    return isStream
        ? StreamBuilder<DocumentSnapshot>(
            stream: users.doc(documentId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.red.withOpacity(0.6),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  'loading...',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black38,
                  ),
                );
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text(
                  'Document does not exist',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.red.withOpacity(0.6),
                  ),
                );
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;
              final name = data['name'].toString();
              return Text(
                name,
                overflow: TextOverflow.ellipsis,
              );
            },
          )
        : FutureBuilder<DocumentSnapshot>(
            future: users.doc(documentId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.red.withOpacity(0.6),
                    ));
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text('Document does not exist',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.red.withOpacity(0.6),
                    ));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                final name = data['name'].toString();
                return Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                );
              }

              return const Text(
                'loading...',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black38,
                ),
              );
            },
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('documentId', documentId));
    properties.add(DiagnosticsProperty<bool>('isStream', isStream));
  }
}

class GetNumberOfFollow extends StatelessWidget {
  const GetNumberOfFollow(
      {Key? key, required this.documentId, required this.typeOfReturnNumber})
      : super(key: key);
  final String documentId;
  final Follow_Screen_Name typeOfReturnNumber;

  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        AccountScreen.localRefDatabase.collection('users');

    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(documentId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || (snapshot.hasData && !snapshot.data!.exists)) {
          return const Text('NaN');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('...');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final int returnNumber;
        switch (typeOfReturnNumber) {
          case Follow_Screen_Name.follower:
            final followers = data['followers'] as List;
            returnNumber = followers.length;
            break;
          case Follow_Screen_Name.following:
            final following = data['following'] as List;
            returnNumber = following.length;
            break;
          default:
            returnNumber = 0;
            break;
        }

        return Text(
          '$returnNumber',
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('documentId', documentId));
    properties.add(EnumProperty<Follow_Screen_Name>(
        'typeOfReturnNumber', typeOfReturnNumber));
  }
}

class GetLegit extends StatelessWidget {
  const GetLegit({
    Key? key,
    required this.documentId,
  }) : super(key: key);
  final String documentId;

  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        AccountScreen.localRefDatabase.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('NaN',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.red.withOpacity(0.6),
              ));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('NaN',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.red.withOpacity(0.6),
              ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          var legit = double.parse(data['legit'].toString());
          legit = legit > 5 ? 5 : legit;
          legit = legit < 0 ? 0 : legit;
          return Text('$legit');
        }

        return const Text(
          'loading...',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black38,
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('documentId', documentId));
  }
}
