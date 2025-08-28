
import 'dart:convert';

Absentemp absentempFromJson(String str) => Absentemp.fromJson(json.decode(str));

String absentempToJson(Absentemp data) => json.encode(data.toJson());

class Absentemp {
    int id;
    String name;
    String mobile;
    dynamic empid;
    List<dynamic> attendances;

    Absentemp({
        required this.id,
        required this.name,
        required this.mobile,
        required this.empid,
        required this.attendances,
    });

    factory Absentemp.fromJson(Map<String, dynamic> json) => Absentemp(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        empid: json["empid"],
        attendances: List<dynamic>.from(json["attendances"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "empid": empid,
        "attendances": List<dynamic>.from(attendances.map((x) => x)),
    };
}
