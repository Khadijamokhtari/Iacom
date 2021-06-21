import 'dart:convert';

List<Service> serviceFromJson(String str) => List<Service>.from(json.decode(str).map((x) => Service.fromMap(x)));

String serviceToJson(List<Service> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Service {
  String id_act;
  String nom_art;
  String sous_titre;
  String description;
  String image_art;

  Service({
    this.id_act,
    this.nom_art,
    this.sous_titre,
    this.description,
    this.image_art,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
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