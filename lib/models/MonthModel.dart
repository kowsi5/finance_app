
class MonthModel {
  int id;
  String tmMonth;
  String enMonth;

  MonthModel({
    required this.id,
    required this.tmMonth,
    required this.enMonth,
  });

  factory MonthModel.fromJson(Map<String, dynamic> json) => MonthModel(
        id: json["id"],
        tmMonth: json["tmMonth"],
        enMonth: json["enMonth"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tmMonth": tmMonth,
        "enMonth": enMonth,
      };
}
