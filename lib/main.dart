import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/services/auth/auth_gate.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:flutter_application_1/services/notifications_provider.dart';
import 'package:flutter_application_1/services/push_notification_service.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  PushNotificationService().initialize();

  runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(
      // theme provider
      create: (context) => ThemeProvider()),

      // restaurant provider
    ChangeNotifierProvider(
      create: (context) => Restaurant()),

      // notifications provider
    ChangeNotifierProvider(
      create: (context) => NotificationProvider())
      
  
  ],
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData
    );
  }
}
