import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  late final bool error;
  final String message;
  final String? accessToken;
  final Object? data;

  BaseResponse(
      {required this.accessToken,
      required this.error,
      required this.message,
      required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      accessToken: json['accessToken'],
      error: json['error'],
      message: json['message'],
      data: json['data']);

  Map<String, dynamic> toJson() => {
        "error": error,
        'message': message,
        'accessToken': accessToken,
        'data': data
      };

  @override
  String toString() {
    return 'LoginResponse{error: $error, message: $message, accessToken: $accessToken, data: $data}';
  }
}
