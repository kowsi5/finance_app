
class CommonAPIResponse {
  int code;
  String message;

  CommonAPIResponse({
    required this.code,
    required this.message,
  });

  factory CommonAPIResponse.fromJson(Map<String, dynamic> json) => CommonAPIResponse(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}