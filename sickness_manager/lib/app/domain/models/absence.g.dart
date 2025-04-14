// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Absence _$AbsenceFromJson(Map<String, dynamic> json) => Absence(
  id: (json['id'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  crewId: (json['crewId'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  admitterId: (json['admitterId'] as num?)?.toInt(),
  admitterNote: json['admitterNote'] as String?,
  confirmedAt:
      json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  memberNote: json['memberNote'] as String?,
  rejectedAt:
      json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
  type: json['type'] as String?,
);

Map<String, dynamic> _$AbsenceToJson(Absence instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'crewId': instance.crewId,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'admitterId': instance.admitterId,
  'admitterNote': instance.admitterNote,
  'createdAt': instance.createdAt?.toIso8601String(),
  'confirmedAt': instance.confirmedAt?.toIso8601String(),
  'rejectedAt': instance.rejectedAt?.toIso8601String(),
  'memberNote': instance.memberNote,
  'type': instance.type,
};
