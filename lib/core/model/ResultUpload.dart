
class ResultUpload {
  ResUpload? data;
  bool status;
  String message;

  ResultUpload({this.data, required this.status, required this.message});

  factory ResultUpload.fromJson(Map<String, dynamic> json) => ResultUpload(
      data: ResUpload.fromJson(json["data"]),
      status: json["status"],
      message: json["message"]);

  Map<String, dynamic> toJson() => {"data": data == null ? "" : data!.toJson()};
}


class ResUpload {
  String image_name = "";

  ResUpload({
    required this.image_name,
  });

  factory ResUpload.fromJson(Map<String, dynamic> json) => ResUpload(
      image_name: json["image_name"].toString()
  );

  Map<String, dynamic> toJson() => {
    "image_name": image_name
  };
}