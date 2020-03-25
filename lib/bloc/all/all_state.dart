import 'package:coronatracker/bloc/all/bloc.dart';
import 'package:coronatracker/data/model/all/all_cases_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AllState extends Equatable {
  const AllState();
}

class InitialAllState extends AllState {
  @override
  List<Object> get props => [];
}

class LoadingAllState extends AllState {
  @override
  List<Object> get props => null;
}

class LoadedAllState extends AllState {
  AllCasesResponse response;
  LoadedAllState({@required this.response});

  @override
  List<Object> get props => [response];
}

class ErrorAllState extends AllState {
  String message;
  ErrorAllState({@required this.message});
  @override
  List<Object> get props => [message];
}
