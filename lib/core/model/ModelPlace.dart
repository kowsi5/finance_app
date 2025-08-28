class ModelPlace {
  String full_name = "";
  String place_id = "";
  String primary_name = "";
  String secondary_name = "";
  String latlng = "";

  ModelPlace({
    required this.full_name,
    required this.place_id,
    required this.primary_name,
    required this.secondary_name,
    required this.latlng,
  });

  factory ModelPlace.fromJson(Map<String, dynamic> json) => ModelPlace(
        full_name: json["full_name"].toString(),
        place_id: json["place_id"].toString(),
        primary_name: json["primary_name"].toString(),
        secondary_name: json["secondary_name"].toString(),
        latlng: json["latlng"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "full_name": full_name,
        "place_id": place_id,
        "primary_name": primary_name,
        "secondary_name": secondary_name,
        "latlng": latlng
      };
}
