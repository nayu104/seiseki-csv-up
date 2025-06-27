import 'package:flutter/material.dart';
import 'package:drift/screens/home_screen.dart';
import 'package:drift/screens/credits_screen.dart';
import 'package:drift/screens/timetable_screen.dart';
import 'package:drift/screens/class_details_screen.dart';
import 'package:drift/screens/course_registration_screen.dart';
import 'package:drift/screens/csv_upload_screen.dart';

void main() {
  runApp(const MyApp());
}

// このウィジェットはアプリのルート（最上位）です。
class MyApp extends StatelessWidget {
  //継承
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '単位分類表プリ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/grade_csv_upload': (context) => const CourseRegistrationScreen(),
        '/credits': (context) => const CreditsScreen(),
        '/timetable': (context) => const TimetableScreen(),
        '/class_details': (context) {
          final className =
              ModalRoute.of(context)!.settings.arguments as String;
          return ClassDetailsScreen(className: className);
        },
        '/csv_upload': (context) => const CsvUploadScreen(),
      },
    );
  }
}
