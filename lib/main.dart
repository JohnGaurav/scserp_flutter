import 'package:admin/pages/admission/application-single.dart';
import 'package:admin/pages/admission/applications-pg.dart';
import 'package:admin/pages/admission/applications-ug.dart';
import 'package:admin/pages/admission/enrolled-std.dart';
import 'package:admin/pages/admission/interview.dart';
import 'package:admin/pages/admission/payments.dart';
import 'package:admin/pages/admission/phase2.dart';
import 'package:admin/pages/admission/registration.dart';
import 'package:admin/pages/auth/forgot-password.dart';
import 'package:admin/pages/dashboard.dart';
import 'package:admin/pages/auth/login.dart';
import 'package:admin/pages/master/campus.dart';
import 'package:admin/pages/master/deanery.dart';
import 'package:admin/pages/master/errorlogbook.dart';
import 'package:admin/pages/master/fee-structure-sil.dart';
import 'package:admin/pages/master/fee-structure-son.dart';
import 'package:admin/pages/master/hours.dart';
import 'package:admin/pages/master/semesters.dart';
import 'package:admin/pages/master/session.dart';
import 'package:admin/pages/master/subject/subjects.dart';
import 'package:admin/pages/master/weekdays.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/dashboard',
      routes: {
        //errorlogging
        '/errorlogs': (ctx) => ErrorLogBookScreen(),

        "/login": (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/forgot': (ctx) => ForgotScreen(),
        // master
        '/campus': (ctx) => CampusMasterScreen(),
        '/session': (ctx) => SessionScreen(),
        '/deanery': (ctx) => DeaneryScreen(),
        '/fee-son': (ctx) => FeeStructureSonScreen(),
        '/fee-sil': (ctx) => FeeStructureSilScreen(),
        '/subjects': (ctx) => SubjectScreen(),
        '/semesters': (ctx) => SemesterScreen(),
        '/weekdays': (ctx) => WeekdaysScreen(),
        '/hours': (ctx) => HoursScreen(),
        //admission
        '/registration': (ctx) => AdmissionRegistrationScreen(),
        '/ug-applications': (ctx) => UGApplicationScreen(),
        '/pg-applications': (ctx) => PGApplicationScreen(),
        '/application-single': (ctx) => ApplicationSingleScreen(),
        '/payments': (ctx) => PaymentScreen(),
        '/interview': (ctx) => SelectionInterviewScreen(),
        '/selection-phasetwo': (ctx) => SelectionPhaseTwoScreen(),
        '/enrolled-stdlist': (ctx) => EnrolledStudentScreen(),
      },
    );
  }
}
