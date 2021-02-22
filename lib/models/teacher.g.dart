// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return Teacher()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..SN = json['SN'] as String
    ..avatar = json['avatar'] as String
    ..collage = json['collage'] as String
    ..age = json['age'] as num
    ..description = json['description'] as String
    ..price = json['price'] as num
    ..skilled = json['skilled'] as List
    ..certificates = json['certificates'] as List;
}

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'SN': instance.SN,
      'avatar': instance.avatar,
      'collage': instance.collage,
      'age': instance.age,
      'description': instance.description,
      'price': instance.price,
      'skilled': instance.skilled,
      'certificates': instance.certificates,
    };
