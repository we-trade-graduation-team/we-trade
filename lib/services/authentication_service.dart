import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/authentication/user_model.dart' as user_model;

class AuthenticationService {
  AuthenticationService(this._firebaseAuth);

  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<firebase_auth.User?> get authStateChanges =>
      _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  user_model.User? _userFromFirebaseUser(firebase_auth.User? user) {
    return user != null
        ? user_model.User(
            uid: user.uid,
            email: user.email,
          )
        : null;
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<user_model.User?> signIn({
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
    } on firebase_auth.FirebaseAuthException catch (_) {
      return null;
      // return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<user_model.User?> signUp({
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
    } on firebase_auth.FirebaseAuthException catch (_) {
      return null;
      // return e.message;
    }
  }
}
