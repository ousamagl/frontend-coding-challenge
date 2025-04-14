import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absence.g.dart';

@JsonSerializable()
class Absence extends Equatable {
  const Absence({
    required this.id,
    required this.userId,
    required this.crewId,
    required this.startDate,
    required this.endDate,
    this.admitterId,
    this.admitterNote,
    this.confirmedAt,
    this.createdAt,
    this.memberNote,
    this.rejectedAt,
    this.type,
  });

  factory Absence.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFromJson(json);

  Map<String, dynamic> toJson() => _$AbsenceToJson(this);

  final int id;
  final int userId;
  final int crewId;
  final DateTime startDate;
  final DateTime endDate;

  final int? admitterId;
  final String? admitterNote;
  final DateTime? createdAt;
  final DateTime? confirmedAt;
  final DateTime? rejectedAt;
  final String? memberNote;
  final String? type;

  @override
  List<Object?> get props => [
    admitterId,
    admitterNote,
    confirmedAt,
    createdAt,
    crewId,
    endDate,
    id,
    memberNote,
    rejectedAt,
    startDate,
    type,
    userId,
  ];
}
