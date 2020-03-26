import 'package:coronatracker/data/model/countries/countries_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();
}

class InitialCountriesState extends CountriesState {
  @override
  List<Object> get props => [];
}

class LoadingCountryCasesState extends CountriesState {
  @override
  List<Object> get props => null;
}

class LoadedCountryCasesState extends CountriesState {
  CountriesResponse countriesResponse;
  LoadedCountryCasesState({@required this.countriesResponse});
  @override
  List<Object> get props => [countriesResponse];
}

class ErrorCountryCasesState extends CountriesState {
  String message;
  ErrorCountryCasesState({@required this.message});
  @override
  List<Object> get props => null;
}


