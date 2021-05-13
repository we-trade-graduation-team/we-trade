import 'package:firebase_auth/firebase_auth.dart';
import '../../models/authentication/user_model.dart';

class AuthenticationService {
  AuthenticationService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            email: user.email,
          )
        : null;
  }

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<UserModel?> get authStateChanges =>
      _firebaseAuth.idTokenChanges().map(_userFromFirebaseUser);

  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      return _userFromFirebaseUser(user);
      // return 'Signed in';
    } on FirebaseAuthException catch (_) {
      return null;
      // return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<UserModel?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      return _userFromFirebaseUser(user);
      // return 'Signed up';
    } on FirebaseAuthException catch (_) {
      return null;
      // return e.message;
    }
  }

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      // return null;
    }
  }
}
