// To parse this JSON data, do
//
//     final cat = catFromJson(jsonString);

import 'dart:convert';

Cat catFromJson(String str) => Cat.fromJson(json.decode(str));

String catToJson(Cat data) => json.encode(data.toJson());

class Cat {
    String name;
    String image;
    String description;
    String type;
    String sex;
    String id;

    Cat({
        required this.name,
        required this.image,
        required this.description,
        required this.type,
        required this.sex,
        required this.id,
    });

    factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        name: json["name"],
        image: json["image"],
        description: json["description"],
        type: json["type"],
        sex: json["sex"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description": description,
        "type": type,
        "sex": sex,
        "id": id,
    };
}
