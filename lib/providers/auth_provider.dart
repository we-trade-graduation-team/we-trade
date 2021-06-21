import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cloud_firestore/user_model/user/user.dart' as user_model;
import '../services/firestore/firestore_path.dart';
import '../services/message/algolia_user_service.dart';
import '../ui/message_features/const_string/const_str.dart';
import '../utils/model_properties/model_properties.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  registering,
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._auth) {
    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Firebase Auth object
  final FirebaseAuth _auth;

  //Default status
  Status _status = Status.uninitialized;

  Status get status => _status;

  final _usersRef =
      FirebaseFirestore.instance.collection(FirestorePath.users());

  // /// Changed to idTokenChanges as it updates depending on more cases.
  // Stream<user_model.User?> get authStateChanges =>
  //     _auth.idTokenChanges().map(_userFromFirebase);

  Stream<user_model.User?> get user =>
      _auth.authStateChanges().map(_userFromFirebase);

  // user_model.User? get _currentUser => _userFromFirebase(_auth.currentUser);

  //Create user object based on the given FirebaseUser
  user_model.User? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }

    return user_model.User(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      isEmailVerified: user.emailVerified,
      avatarUrl: user.photoURL,
    );
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);

      _status = Status.authenticated;
    }

    notifyListeners();
  }

  //Method to handle user sign in using email and password
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _status = Status.authenticating;

      notifyListeners();

      final _result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final _firebaseAuthUser = _result.user;

      final _newUser = _userFromFirebase(_firebaseAuthUser);

      if (_newUser != null) {
        const _presenceField = ModelProperties.userPresenceProperty;

        final _presenceData = {
          _presenceField: true,
        };
        // ignore: unawaited_futures
        UserServiceAlgolia()
            .updateUserPresence(id: _newUser.uid!, presence: true);
        // Add new user to users Collection
        await _usersRef.doc(_newUser.uid).update(_presenceData);
        // ignore: unawaited_futures

      }
    } on FirebaseAuthException catch (e) {
      // print("Error on the sign in = " + e.toString());
      _status = Status.unauthenticated;

      notifyListeners();

      return e.code;
    }
  }

  //Method for new user registration using email and password
  Future<String?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      _status = Status.registering;

      notifyListeners();

      final _result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final _firebaseAuthUser = _result.user!;

      final _newUser = _userFromFirebase(_firebaseAuthUser);

      if (_newUser != null) {
        _newUser
          ..name = name
          ..lastSeen = DateTime.now().millisecondsSinceEpoch
          ..presence = true;

        final initialUserData = _newUser.toJson();

        initialUserData['avatarUrl'] = userImageStr;
        initialUserData['bio'] = '';
        initialUserData['createAt'] = DateTime.now();
        initialUserData['legit'] = 0;
        initialUserData['ratingCount'] = 0;
        initialUserData['followers'] = <String>[];
        initialUserData['following'] = <String>[];
        initialUserData['hiddenPosts'] = <String>[];
        initialUserData['location'] = '';
        initialUserData['objectID'] = _newUser.uid;
        initialUserData['phoneNumber'] = '';
        initialUserData['posts'] = <String>[];
        initialUserData['tradingHistory'] = <String>[];
        initialUserData['wishList'] = <String>[];

        await Future.wait([
          // Set name in firestore database
          _usersRef.doc(_newUser.uid).set(initialUserData),
          // Set display name
          _firebaseAuthUser.updateDisplayName(name),
        ]);

        await UserServiceAlgolia().addUser(_newUser);
      }
    } on FirebaseAuthException catch (e) {
      // print("Error on the new user registration = " + e.toString());
      _status = Status.unauthenticated;

      notifyListeners();

      return e.code;
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future<void> signOut() async {
    const _lastSeenField = ModelProperties.userLastSeenProperty;

    const _presenceField = ModelProperties.userPresenceProperty;

    final _newData = {
      _lastSeenField: DateTime.now().millisecondsSinceEpoch,
      _presenceField: false,
    };

    final _currentUser = _auth.currentUser;

    // ignore: unawaited_futures
    await UserServiceAlgolia()
        .updateUserPresence(id: _currentUser!.uid, presence: false);
    await Future.wait([
      // Update lastSeen and presence
      _usersRef.doc(_currentUser.uid).update(_newData),
      // Sign out for current user
      _auth.signOut(),
    ]);

    // TODO update algolia presence
    _status = Status.unauthenticated;

    notifyListeners();
  }
}
