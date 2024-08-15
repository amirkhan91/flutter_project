// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonDetailImpl _$$PersonDetailImplFromJson(Map<String, dynamic> json) =>
    _$PersonDetailImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$$PersonDetailImplToJson(_$PersonDetailImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
    };
