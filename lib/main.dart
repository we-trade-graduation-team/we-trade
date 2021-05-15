// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'app.dart';

// bool useFirestoreEmulator = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // if (useFirestoreEmulator) {
  //   FirebaseFirestore.instance.settings = const Settings(
  //     host: 'localhost:8080',
  //     sslEnabled: false,
  //     persistenceEnabled: false,
  //   );
  // }
  runApp(const App());
}
