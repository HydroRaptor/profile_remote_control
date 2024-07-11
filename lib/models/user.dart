import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  late num userId;
  late num id;
  late String title;
  late String body;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  get users => null;
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
