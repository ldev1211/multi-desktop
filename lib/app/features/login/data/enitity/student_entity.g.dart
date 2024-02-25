// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentEntity _$StudentEntityFromJson(Map<String, dynamic> json) =>
    StudentEntity(
      json['mssv'] as String,
      json['hoten'] as String,
      json['sdt'] as String,
      json['gioitinh'] as int,
      json['malop'] as String,
      json['pers_email'] as String,
      json['fb'] as String,
      json['ngaysinh'] as String,
      json['avt'] as String,
      json['bch'] as int,
      json['bcs'] as int,
      json['ctv'] as int,
      json['hide_pers_email'] as int,
      json['hide_fb'] as int,
      json['hide_phone'] as int,
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
