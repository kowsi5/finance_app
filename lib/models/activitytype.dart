class Activitytypemodal {
  int id;
  String name;
  int user_id;
  String fromDate;
  String toDate;
  String? comments;
  String activityType;
  String? permissionTiming;
  String status;

  Activitytypemodal({
    required this.id,
    required this.name,
    required this.user_id,
    required this.fromDate,
    required this.toDate,
    this.comments,
    required this.activityType,
    this.permissionTiming,
    required this.status,
  });

  factory Activitytypemodal.fromJson(Map<String, dynamic> json) =>
      Activitytypemodal(
        id: json["id"],
        name: json["name"],
        user_id: json["user_id"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        comments: json["comments"] ?? "",
        activityType: json["activity_type"],
        permissionTiming: json["permission_timing"] ?? "",
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": user_id,
        "from_date": fromDate,
        "to_date": toDate,
        "comments": comments,
        "activity_type": activityType,
        "permission_timing": permissionTiming,
        "status": status,
      };
}
