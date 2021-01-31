import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_session/api/models/user.dart';

abstract class CubitApiState extends Equatable {
  const CubitApiState();

  @override
  List<Object> get props => [];
}

class CubitApiStateInitial extends CubitApiState {}

class CubitApiStateLoading extends CubitApiState {}

class CubitApiStateSuccess extends CubitApiState {
  final BuiltList<User> list;

  CubitApiStateSuccess({@required this.list});

  @override
  List<Object> get props => [list];
}

class CubitApiStateFail extends CubitApiState {
  final String error;

  CubitApiStateFail({this.error});

  @override
  List<Object> get props => [error];
}
