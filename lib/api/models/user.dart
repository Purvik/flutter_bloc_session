import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  @nullable
  int get id;
  String get firstName;
  String get lastName;

  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  static Serializer<User> get serializer => _$userSerializer;
}
