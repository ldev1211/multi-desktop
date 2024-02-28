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
  @JsonKey(name: "bch")
  int? bch;
  @JsonKey(name: "bcs")
  int? bcs;
  @JsonKey(name: "ctv")
  int? ctv;
  @JsonKey(name: "hide_pers_email")
  int? isHideEmail;
  @JsonKey(name: "hide_fb")
  int? isHideFb;
  @JsonKey(name: "hide_phone")
  int? isHidePhone;

  StudentEntity(
      {required this.stuCode,
      this.fullName,
      this.phoneNumber,
      this.gender,
      this.classCode,
      this.personalEmail,
      this.linkFb,
      this.birthDay,
      this.avt,
      this.bch,
      this.bcs,
      this.ctv,
      this.isHideEmail,
      this.isHideFb,
      this.isHidePhone});

  factory StudentEntity.fromJson(Map<String, dynamic> json) =>
      _$StudentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StudentEntityToJson(this);
}
