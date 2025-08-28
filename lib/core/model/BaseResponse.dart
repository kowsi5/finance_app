import '../utils/Support.dart';

class BaseResponse {
  bool status;
  String message;

  BaseResponse(
      {required this.status, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      status: json["status"],
      message: json["message"]);

}


class BaseSimpleResponse {
  String success;

  BaseSimpleResponse({
    required this.success,
  });

  factory BaseSimpleResponse.fromJson(Map<String, dynamic> json) =>
      BaseSimpleResponse(
        success: formatResponseData(json["success"].toString()),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
