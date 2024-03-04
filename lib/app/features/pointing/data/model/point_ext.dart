class ResponsePointExt {
  bool error;
  String message;
  List<PointExt> data;

  ResponsePointExt(
      {required this.error, required this.message, required this.data});

  @override
  String toString() {
    return 'ResponsePointExt{error: $error, message: $message, data: $data}';
  }

  factory ResponsePointExt.fromJson(Map<String, dynamic> json) =>
      ResponsePointExt(
        error: json["error"],
        message: json["message"],
        data:
            List<PointExt>.from(json["data"].map((x) => PointExt.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PointExt {
  int id;
  double? stt;
  String content;
  int? pointRule;
  TypeRow type;
  int? parent;
  int? pointSelf;
  int? pointFinal;

  PointExt({
    required this.id,
    required this.stt,
    required this.content,
    required this.pointRule,
    required this.type,
    required this.parent,
    this.pointSelf,
    this.pointFinal,
  });

  factory PointExt.fromJson(Map<String, dynamic> json) => PointExt(
        id: json["id"],
        stt: json["stt"]?.toDouble(),
        content: json["content"],
        pointRule: json["pointRule"],
        type: typeValues.map[json["type"]]!,
        parent: json["parent"],
        pointSelf: json["pointSelf"],
        pointFinal: json["pointFinal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stt": stt,
        "content": content,
        "pointRule": pointRule,
        "type": typeValues.reverse[type],
        "parent": parent,
        "pointSelf": pointSelf,
        "pointFinal": pointFinal,
      };

  @override
  String toString() {
    return 'PointExt{id: $id, stt: $stt, content: $content, pointRule: $pointRule, type: $type, parent: $parent, pointSelf: $pointSelf, pointFinal: $pointFinal}';
  }
}

enum TypeRow { HEADER, ROW, TOTAL }

final typeValues = EnumValues(
    {"header": TypeRow.HEADER, "row": TypeRow.ROW, "total": TypeRow.TOTAL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
