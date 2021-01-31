// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_handler.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$APIHandler extends APIHandler {
  _$APIHandler([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = APIHandler;

  @override
  Future<Response<BuiltList<User>>> getUsers() {
    final $url = 'api/get-users';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<User>, User>($request);
  }
}
