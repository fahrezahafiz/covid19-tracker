import 'package:covid19tracker/core/locator.dart';
import 'package:covid19tracker/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setStatusBarColor();
    super.initState();
  }

  void setStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.grey[100]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(Colors.white));

    await FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(
        useWhiteForeground(Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}
