import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/onboarding_screen.dart';
import 'screens/location_screen.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';

import 'services/notification_service_web.dart' if (dart.library.io) 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize services
    await NotificationService.initialize();
    await StorageService.initialize();
  } catch (e) {
    print('Error initializing services: $e');
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nature Sync Alarm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: OnboardingScreen(),
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/location': (context) => LocationScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}