import 'package:equatable/equatable.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();
}

class FetchCountryCasesEvent extends CountriesEvent {
  @override
  List<Object> get props => null;
}
