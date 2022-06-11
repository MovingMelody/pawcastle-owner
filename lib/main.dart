import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/firebase_options.dart';
import 'package:petowner/src/app/app.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/config/config.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const bool useLocalEmulator = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  if (useLocalEmulator) {
    await _connectToFirebaseEmulator();
  }

  await setupLocator();
  setupConfig();
  runApp(const MyApp());
}

/// Connnect to firestore emulator
Future _connectToFirebaseEmulator() async {
  // Replace your IP here
  const String localHostString = '192.168.50.24';

  FirebaseFirestore.instance.settings = const Settings(
    host: '$localHostString:8081',
    sslEnabled: false,
    persistenceEnabled: false,
  );
}
