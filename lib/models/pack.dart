import 'dart:convert';

List<Pack> packFromJson(String str) => List<Pack>.from(json.decode(str).map((x) => Pack.fromMap(x)));

String packToJson(List<Pack> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pack {
  String id_act;
  String nom_art;
  String sous_titre;
  String description;
  String image_art;

  Pack({
    this.id_act,
    this.nom_art,
    this.sous_titre,
    this.description,
    this.image_art,
  });

  factory Pack.fromMap(Map<String, dynamic> json) => Pack(
    id_act: json["id_act"],
    nom_art: json["nom_art"],
    sous_titre: json["sous_titre"],
    description: json["description"],
    image_art: json["image_art"],
  );

  Map<String, dynamic> toJson() => {
    "id_act": id_act,
    "nom_art": nom_art,
    "sous_titre": sous_titre,
    "description": description,
    "image_art": image_art,
  };
}