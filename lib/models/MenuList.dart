import 'dart:ui';

class MenuList {
  List<Menu> menu;

  MenuList({
    required this.menu,
  });

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
      };
}

class Menu {
  String title;
  String image;
  String object;

  Menu({
    required this.title,
    required this.image,
    required this.object,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        title: json["title"],
        image: json["image"],
        object: json["object"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "object": object,
      };
}

class Menulist {
  String title;
  Color color;
  String object;

  Menulist({
    required this.title,
    required this.color,
    required this.object,
  });

  factory Menulist.fromJson(Map<String, dynamic> json) => Menulist(
        title: json["title"],
        color: json["color"],
        object: json["object"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": color,
        "object": object,
      };
}
