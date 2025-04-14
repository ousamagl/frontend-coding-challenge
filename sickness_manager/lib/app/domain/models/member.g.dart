// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
  crewId: (json['crewId'] as num).toInt(),
  id: (json['id'] as num).toInt(),
  image: json['image'] as String,
  name: json['name'] as String,
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
  'crewId': instance.crewId,
  'id': instance.id,
  'image': instance.image,
  'name': instance.name,
  'userId': instance.userId,
};
