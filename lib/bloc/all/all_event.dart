import 'package:equatable/equatable.dart';

abstract class AllEvent extends Equatable {
  const AllEvent();
}

class FetchAllEvent extends AllEvent {
  @override
  List<Object> get props => null;
}
