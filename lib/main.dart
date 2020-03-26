import 'package:coronatracker/bloc/all/all_bloc.dart';
import 'package:coronatracker/bloc/countries/bloc.dart';
import 'package:coronatracker/data/repository/all_repository.dart';
import 'package:coronatracker/data/repository/countries_repository.dart';
import 'package:coronatracker/screens/countries/countries_screen.dart';
import 'package:coronatracker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(CoronaTrackerApp());

class CoronaTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => BlocProvider(
              create: (context) => AllBloc(repository: AllRepositoryImpl()),
              child: Home(),
            ),
        Countries.routeName: (context) => BlocProvider(
            create: (context) => CountriesBloc(repository: CountriesRepositoryImpl()),
            child: Countries())
      },
    );
  }
}

