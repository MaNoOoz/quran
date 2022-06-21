class Qaree {
  Qaree({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  String identifier;
  Language? language;
  String name;
  String englishName;
  Format? format;
  Type? type;
  dynamic direction;

  factory Qaree.fromJson(Map<String, dynamic> json) => Qaree(
        identifier: json["identifier"],
        language: languageValues.map[json["language"]],
        name: json["name"],
        englishName: json["englishName"],
        format: formatValues.map[json["format"]],
        type: typeValues.map[json["type"]],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "language": languageValues.reverse[language],
        "name": name,
        "englishName": englishName,
        "format": formatValues.reverse[format],
        "type": typeValues.reverse[type],
        "direction": direction,
      };
}

enum Format { AUDIO }

final formatValues = EnumValues({"audio": Format.AUDIO});

enum Language { AR }

final languageValues = EnumValues({"ar": Language.AR});

enum Type { VERSEBYVERSE }

final typeValues = EnumValues({"versebyverse": Type.VERSEBYVERSE});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
