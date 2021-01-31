import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_session/api/models/user.dart';

abstract class BlocApiHomeState extends Equatable {
  const BlocApiHomeState();

  @override
  List<Object> get props => [];
}

class HomeStateInitial extends BlocApiHomeState {}

class HomeStateLoading extends BlocApiHomeState {}

class HomeStateSuccess extends BlocApiHomeState {
  final BuiltList<User> list;

  HomeStateSuccess({@required this.list});

  @override
  List<Object> get props => [list];
}

class HomeStateFail extends BlocApiHomeState {
  final String error;

  HomeStateFail({this.error});

  @override
  List<Object> get props => [error];
}

class HomeStateLogout extends BlocApiHomeState {}
