import 'package:json_annotation/json_annotation.dart';

part 'student_entity.g.dart';

@JsonSerializable()
class StudentEntity {
  @JsonKey(name: "mssv")
  String stuCode;
  @JsonKey(name: "hoten")
  String? fullName;
  @JsonKey(name: "sdt")
  String? phoneNumber;
  @JsonKey(name: "gioitinh")
  int? gender;
  @JsonKey(name: "malop")
  String? classCode;
  @JsonKey(name: "pers_email")
  String? personalEmail;
  @JsonKey(name: "fb")
  String? linkFb;
  @JsonKey(name: "ngaysinh")
  String? birthDay;
  @JsonKey(name: "avt")
  String? avt;
  @JsonKey(name: "role")
  int? role;

  StudentEntity({
    required this.stuCode,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.classCode,
    this.personalEmail,
    this.linkFb,
    this.birthDay,
    this.avt,
    this.role,
  });

  factory StudentEntity.fromJson(Map<String, dynamic> json) =>
      _$StudentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StudentEntityToJson(this);
}
