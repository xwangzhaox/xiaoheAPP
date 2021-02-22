import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';
@JsonSerializable()
class Teacher {
    Teacher();

    num id;
    String name;
    String SN;
    String avatar;
    String collage;
    num age;
    String description;
    num price;
    List skilled;
    List certificates;

    factory Teacher.fromJson(Map<String,dynamic> json) => _$TeacherFromJson(json);
    Map<String, dynamic> toJson() => _$TeacherToJson(this);
}