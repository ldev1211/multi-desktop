class Cert {
  List<Major> major;
  List<Individual> individual;

  Cert({
    required this.major,
    required this.individual,
  });

  factory Cert.fromJson(Map<String, dynamic> json) => Cert(
        major: List<Major>.from(json["major"].map((x) => Major.fromJson(x))),
        individual: List<Individual>.from(
            json["individual"].map((x) => Individual.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "major": List<dynamic>.from(major.map((x) => x.toJson())),
        "individual": List<dynamic>.from(individual.map((x) => x.toJson())),
      };
}

class Individual {
  String title;
  List<String> img;

  Individual({
    required this.title,
    required this.img,
  });

  factory Individual.fromJson(Map<String, dynamic> json) => Individual(
        title: json["title"],
        img: List<String>.from(json["img"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "img": List<dynamic>.from(img.map((x) => x)),
      };
}

class Major {
  String name;

  Major({
    required this.name,
  });

  factory Major.fromJson(Map<String, dynamic> json) => Major(
        name: json["ten"],
      );

  Map<String, dynamic> toJson() => {
        "ten": name,
      };
}

class ResponseCert {
  bool error;
  String message;
  Cert data;

  ResponseCert({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ResponseCert.fromJson(Map<String, dynamic> json) => ResponseCert(
        error: json["error"],
        message: json["message"],
        data: Cert.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}
