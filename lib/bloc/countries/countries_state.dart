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
  List<CountriesResponse> countryList;
  LoadedCountryCasesState({@required this.countryList});
  @override
  List<Object> get props => [countryList];
}

class ErrorCountryCasesState extends CountriesState {
  String message;
  ErrorCountryCasesState({@required this.message});
  @override
  List<Object> get props => null;
}


