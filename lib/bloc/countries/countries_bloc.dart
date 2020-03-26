import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coronatracker/data/model/countries/countries_model.dart';
import 'package:coronatracker/data/repository/countries_repository.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CountriesRepository repository;

  CountriesBloc({@required this.repository});

  @override
  CountriesState get initialState => InitialCountriesState();

  @override
  Stream<CountriesState> mapEventToState(CountriesEvent event,) async* {
    if (event is FetchCountryCasesEvent) {
        yield LoadingCountryCasesState();
    }
    try {
      CountriesResponse countriesResponse = await repository.getCasesByCountry();
       yield LoadedCountryCasesState(countriesResponse: countriesResponse);
    } catch (e) {
       yield ErrorCountryCasesState(message: e.toString());
    }
  }
}
