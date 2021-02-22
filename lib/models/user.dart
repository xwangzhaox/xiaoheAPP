import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
    User();

    String login;
    String avatar_url;
    String type;
    String name;
    String phone_number;
    String company;
    String location;
    String email;
    String bio;
    String created_at;
    String updated_at;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}