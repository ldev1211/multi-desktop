// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentEntity _$StudentEntityFromJson(Map<String, dynamic> json) =>
    StudentEntity(
      stuCode: json['mssv'] as String,
      fullName: json['hoten'] as String?,
      phoneNumber: json['sdt'] as String?,
      gender: json['gioitinh'] as int?,
      classCode: json['malop'] as String?,
      personalEmail: json['pers_email'] as String?,
      linkFb: json['fb'] as String?,
      birthDay: json['ngaysinh'] as String?,
      avt: json['avt'] as String?,
      bch: json['bch'] as int?,
      bcs: json['bcs'] as int?,
      ctv: json['ctv'] as int?,
      isHideEmail: json['hide_pers_email'] as int?,
      isHideFb: json['hide_fb'] as int?,
      isHidePhone: json['hide_phone'] as int?,
    );

Map<String, dynamic> _$StudentEntityToJson(StudentEntity instance) =>
    <String, dynamic>{
      'mssv': instance.stuCode,
      'hoten': instance.fullName,
      'sdt': instance.phoneNumber,
      'gioitinh': instance.gender,
      'malop': instance.classCode,
      'pers_email': instance.personalEmail,
      'fb': instance.linkFb,
      'ngaysinh': instance.birthDay,
      'avt': instance.avt,
      'bch': instance.bch,
      'bcs': instance.bcs,
      'ctv': instance.ctv,
      'hide_pers_email': instance.isHideEmail,
      'hide_fb': instance.isHideFb,
      'hide_phone': instance.isHidePhone,
    };
