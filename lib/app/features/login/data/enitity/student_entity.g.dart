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
      role: json['role'] as int?,
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
      'role': instance.role,
    };
