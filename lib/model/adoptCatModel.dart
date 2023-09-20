// To parse this JSON data, do
//
//     final favoriteDogModel = favoriteDogModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AdoptionCatModel adoptionModelFromJson(String str) =>
    AdoptionCatModel.fromJson(json.decode(str));

String adoptionModelToJson(AdoptionCatModel data) => json.encode(data.toJson());

class AdoptionCatModel {
  AdoptionCatModel({
    required this.userId,
    required this.dogId,
    required this.dogName,
    required this.imageUrl,
    required this.breed,
  });

  String userId;
  String dogId;
  String dogName;
  String imageUrl;
  String breed;

  factory AdoptionCatModel.fromJson(Map<String, dynamic> json) => AdoptionCatModel(
    userId: json["userId"],
    dogId: json["dogId"],
    dogName: json["dogName"],
    imageUrl: json["imageUrl"],
    breed: json["breed"],
  );
  factory AdoptionCatModel.fromFirebaseSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) =>
      AdoptionCatModel(
        userId: json["userId"],
        dogId: json["dogId"],
        dogName: json["dogName"],
        imageUrl: json["imageUrl"],
        breed: json["breed"],
      );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "dogId": dogId,
    "dogName": dogName,
    "imageUrl": imageUrl,
    "breed": breed,
  };
}
