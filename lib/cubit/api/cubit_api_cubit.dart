import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_session/api/api_handler.dart';
import 'package:flutter_bloc_session/api/models/user.dart';
import 'package:provider/provider.dart';

import 'cubit_api_state.dart';

class ApiCubit extends Cubit<CubitApiState> {
  final BuildContext context;
  ApiCubit({@required this.context}) : super(CubitApiStateInitial());

  Future<void> fetchUserListing() async {
    emit(CubitApiStateLoading());
    try {
      Response<BuiltList<User>> apiResponse =
          await Provider.of<APIHandler>(context, listen: false).getUsers();
      if (apiResponse.isSuccessful) {
        emit(CubitApiStateSuccess(list: apiResponse.body));
      } else {
        emit(CubitApiStateFail(error: 'Something went wrong'));
      }
    } catch (e) {
      emit(CubitApiStateFail(error: 'Something went wrong'));
    }
  }
}
