import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


import '../model/catModel.dart';
import '../services/firebase_service.dart';

class CatRepository with ChangeNotifier {
  CollectionReference<CatModel> catRef =
      FirebaseService.db.collection("cats").withConverter<CatModel>(
            fromFirestore: (snapshot, _) {
              return CatModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<CatModel>> getCatData() {
    Stream<QuerySnapshot<CatModel>> response = catRef.snapshots();
    return response;
  }

  Future<DocumentSnapshot<CatModel>> getOneCat(String catId) async {
    try {
      final response = await catRef.doc(catId).get();
      if (!response.exists) {
        throw Exception("Cat doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> addCat(CatModel data) async {
    await catRef.add(data);
    return true;
  }

  Future<bool?> addCats ({required CatModel catModel}) async {
    try{
      final response = await catRef.add(catModel);
      return true;
    }catch (err) {
      return false;
    }
  }

  Future<List<QueryDocumentSnapshot<CatModel>>> getCatFromList (
      List<String> catIds) async {
    try {
      final response =
      await catRef.where(FieldPath.documentId, whereIn: catIds).get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> removeCat(String catId, String userId) async {
    try{
      final response = await catRef.doc(catId).get();
      if (response == null) {
        return false;
      }
      if (response.data()!.userId != userId) {
        return false;
      }
      await catRef.doc(catId).delete();
      return true;
    }catch (err) {
      print(err);
      rethrow;
    }
  }


  Future<List<QueryDocumentSnapshot<CatModel>>> getMyCats(String userId) async {
    try {
      final response = await catRef.where("user_id", isEqualTo: userId).get();
      var cats = response.docs;
      return cats;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool?> editDog({required CatModel cat, required String catId}) async {
    try {
      final response = await catRef.doc(catId).set(cat);
      return true;
    } catch (err) {
      return false;
    }
  }

}
