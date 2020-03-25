import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coronatracker/data/model/all/all_cases_model.dart';
import 'package:coronatracker/data/repository/all_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class AllBloc extends Bloc<AllEvent, AllState> {
  AllRepository repository;

  AllBloc({@required this.repository});

  @override
  AllState get initialState => InitialAllState();

  @override
  Stream<AllState> mapEventToState(AllEvent event,) async* {
    if (event is FetchAllEvent) {
      yield LoadingAllState();
    }
    try {
      AllCasesResponse response = await repository.getAllCases();
      yield LoadedAllState(response: response);
    } catch (e) {
      yield ErrorAllState(message: e.toString());
    }
  }
}
