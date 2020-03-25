import 'package:coronatracker/screens/countries/countries_screen.dart';
import 'package:coronatracker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(CoronaTrackerApp());

class CoronaTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Tracker',
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => Home(),
        Countries.routeName: (context) => Countries()
      },
    );
  }
}
