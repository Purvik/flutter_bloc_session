import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_session/api/api_handler.dart';
import 'package:flutter_bloc_session/api/models/user.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class BlocApiHomeBloc extends Bloc<BlocApiHomeEvent, BlocApiHomeState> {
  final BuildContext context;

  BlocApiHomeBloc({@required this.context}) : super(HomeStateInitial());

  @override
  Stream<BlocApiHomeState> mapEventToState(BlocApiHomeEvent event) async* {
    if (event is HomeEventGet) {
      yield HomeStateLoading();
      try {
        Response<BuiltList<User>> apiResponse =
            await Provider.of<APIHandler>(context, listen: false).getUsers();
        if (apiResponse.isSuccessful) {
          yield HomeStateSuccess(list: apiResponse.body);
        } else {
          yield HomeStateFail(error: 'Something went wrong');
        }
      } catch (e) {
        yield HomeStateFail(error: 'Something went wrong');
      }
    }
    if (event is HomeEventLogout) {
      yield HomeStateLoading();
      await Future.delayed(Duration(milliseconds: 2000));
      yield HomeStateLogout();
    }
  }
}
