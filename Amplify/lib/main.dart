import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'firebase_options.dart'; // Generated via FlutterFire CLI
import 'homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


// Global instances for Analytics
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
final FirebaseAnalyticsObserver analyticsObserver =
FirebaseAnalyticsObserver(analytics: analytics);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amplify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      navigatorObservers: <NavigatorObserver>[
        analyticsObserver, // sends screen_view events to Firebase Analytics
      ],
    );
  }
}
