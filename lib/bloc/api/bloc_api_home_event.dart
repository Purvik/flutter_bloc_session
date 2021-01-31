import 'package:equatable/equatable.dart';

abstract class BlocApiHomeEvent extends Equatable {
  const BlocApiHomeEvent();
  @override
  List<Object> get props => [];
}

class HomeEventGet extends BlocApiHomeEvent {}

class HomeEventLogout extends BlocApiHomeEvent {}
