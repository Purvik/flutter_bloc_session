import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_bloc_session/api/urls.dart';

import 'models/user.dart';

part "api_handler.chopper.dart";

//TODO:3 - Create API Handling file
@ChopperApi(baseUrl: 'api/')
abstract class APIHandler extends ChopperService {
  static APIHandler create([ChopperClient client]) => _$APIHandler(client);

  @Get(path: URLS.API_GET_USERS)
  Future<Response<BuiltList<User>>> getUsers();
}
