import 'package:json_annotation/json_annotation.dart';
import 'package:profile_remote_control/models/user.dart';
part 'users.g.dart';

@JsonSerializable()
class Users {
  Users();

  List<User>? users;
  
  factory Users.fromJson(Map<String,dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
