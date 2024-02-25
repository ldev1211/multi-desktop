class BaseResponse {
  bool error;
  String message;
  dynamic data;

  BaseResponse(
      {required this.error, required this.message, required this.data});
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      BaseResponse(
        error: json["error"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data,
      };
}
