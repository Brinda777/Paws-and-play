import 'package:cloud_firestore/cloud_firestore.dart';

class CatModel {
  String? userId;
  String? catId;
  String? catName;
  String? catDescription;
  int? estimatedPrice;
  String? breed;
  String? color;
  String? imageUrl;
  String? imagepath;

  CatModel({
    this.userId,
    this.catId,
    this.catName,
    this.catDescription,
    this.estimatedPrice,
    this.breed,
    this.imageUrl,
    this.color,
    this.imagepath,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
        userId: json["userId"],
        catId: json["catId"],
        catName: json["catName"],
        catDescription: json["catDescription"],
        estimatedPrice: json["estimatedPrice"],
        color: json["color"],
        breed: json["breed"],
        imageUrl: json["imageUrl"],
        imagepath: json["imagepath"],
      );
  factory CatModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
    CatModel(
      userId: json["userId"],
      catId: json["catId"],
      catName: json["catName"],
      catDescription: json["catDescription"],
      estimatedPrice: json["estimatedPrice"],
      color: json["color"],
      breed: json["breed"],
      imageUrl: json["imageUrl"],
      imagepath: json["imagepath"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "catId": catId,
        "catName": catName,
        "catDescription": catDescription,
        "estimatedPrice": estimatedPrice,
        "breed": breed,
        "color": color,
        "imageUrl": imageUrl,
        "imagepath": imagepath
      };
}
