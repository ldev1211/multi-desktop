import 'package:json_annotation/json_annotation.dart';

part 'student_entity.g.dart';

@JsonSerializable()
class StudentEntity {
  @JsonKey(name: "mssv")
  final String stuCode;
  @JsonKey(name: "hoten")
  final String fullName;
  @JsonKey(name:"sdt")
  final String phoneNumber;
  @JsonKey(name: "gioitinh")
  final int gender;
  @JsonKey(name: "malop")
  final String classCode;
  @JsonKey(name: "pers_email")
  final String personalEmail;
  @JsonKey(name: "fb")
  final String linkFb;
  @JsonKey(name: "ngaysinh")
  final String birthDay;
  @JsonKey(name: "avt")
  final String avt;
  @JsonKey(name: "bch")
  final int bch;
  @JsonKey(name: "bcs")
  final int bcs;
  @JsonKey(name: "ctv")
  final int ctv;
  @JsonKey(name: "hide_pers_email")
  final int isHideEmail;
  @JsonKey(name: "hide_fb")
  final int isHideFb;
  @JsonKey(name: "hide_phone")
  final int isHidePhone;

  StudentEntity(
      this.stuCode,
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
      this.isHidePhone);

  factory StudentEntity.fromJson(Map<String,dynamic> json) => _$StudentEntityFromJson(json);

  Map<String,dynamic> toJson() => _$StudentEntityToJson(this);
}