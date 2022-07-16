// To parse this JSON data, do
//
//     final datamodel = datamodelFromJson(jsonString);

import 'dart:convert';

Datamodel datamodelFromJson(String str) => Datamodel.fromJson(json.decode(str));

String datamodelToJson(Datamodel data) => json.encode(data.toJson());

class Datamodel {
    Datamodel({
        required this.name,
        required this.job,
        required this.id,
        required this.createdAt,
    });

    String name;
    String job;
    String id;
    DateTime createdAt;

    factory Datamodel.fromJson(Map<String, dynamic> json) => Datamodel(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}
