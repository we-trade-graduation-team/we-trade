import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cloud_firestore/user/user.dart' as user_model;

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

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<user_model.User?> get authStateChanges =>
      _auth.idTokenChanges().map(_userFromFirebase);

  Stream<user_model.User?> get user =>
      _auth.authStateChanges().map(_userFromFirebase);

  //Create user object based on the given FirebaseUser
  user_model.User? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }

    return user_model.User(
      uid: user.uid,
      email: user.email,
      username: user.displayName,
      isEmailVerified: user.emailVerified,
      photoURL: user.photoURL,
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
        final _presenceData = {
          'presence': true,
        };

        // Add new user to users Collection
        final _usersRef = FirebaseFirestore.instance.collection('users');
        await _usersRef.doc(_newUser.uid).update(_presenceData);
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
    required String username,
  }) async {
    try {
      _status = Status.registering;

      notifyListeners();

      final _result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final _firebaseAuthUser = _result.user;

      await _firebaseAuthUser?.updateProfile(
        displayName: username,
      );

      final _newUser = _userFromFirebase(_firebaseAuthUser);

      if (_newUser != null) {
        // Set username for new user
        _newUser.username = username;
        _newUser.presence = true;

        // Add new user to users Collection
        final _usersRef = FirebaseFirestore.instance.collection('users');
        await _usersRef.doc(_newUser.uid).set(_newUser.toJson());
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
    await _auth.signOut();

    _status = Status.unauthenticated;

    notifyListeners();

    return Future<void>.delayed(Duration.zero);
  }
}
