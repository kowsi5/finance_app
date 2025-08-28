
class AppLatLng {
  String latitude = "0.0";
  String longitude = "0.0";

  AppLatLng({
    required this.latitude,
    required this.longitude
  });

  factory AppLatLng.fromJson(Map<String, dynamic> json) => AppLatLng(
    latitude: json["latitude"].toString(),
    longitude: json["longitude"].toString()
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude
  };
}