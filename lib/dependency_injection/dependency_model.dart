// To parse this JSON data, do
//
//     final dependencyModel = dependencyModelFromJson(jsonString);

import 'dart:convert';

DependencyModel dependencyModelFromJson(String str) => DependencyModel.fromJson(json.decode(str));

String dependencyModelToJson(DependencyModel data) => json.encode(data.toJson());

class DependencyModel {
    String? sentence;
    String? character;
    String? anime;

    DependencyModel({
        this.sentence,
        this.character,
        this.anime,
    });

    factory DependencyModel.fromJson(Map<String, dynamic> json) => DependencyModel(
        sentence: json["sentence"],
        character: json["character"],
        anime: json["anime"],
    );

    Map<String, dynamic> toJson() => {
        "sentence": sentence,
        "character": character,
        "anime": anime,
    };
}
