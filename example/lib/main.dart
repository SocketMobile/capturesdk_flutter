import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

const AppInfo appInfo = AppInfo(
  appIdAndroid: 'android:com.example.example',
  appKeyAndroid:
      'MC4CFQDNCtjazxILEh8oyT6w/wlaVKqS1gIVAKTz2W6TB9EgmjS1buy0A+3j7nX4',
  appIdIos: 'ios:com.example.example',
  appKeyIos:
      'MC0CFA1nzK67TLNmSw/QKFUIiedulUUcAhUAzT6EOvRwiZT+h4qyjEZo9oc0ONM=',
  developerId: 'bb57d8e1-f911-47ba-b510-693be162686a',
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SingleEntry Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0A84FF),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
