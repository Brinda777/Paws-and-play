import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/catModel.dart';
import '../repositories/CatRepository.dart';

class CatViewModel with ChangeNotifier {
  CatRepository _catRepository = CatRepository();
  Stream<QuerySnapshot<CatModel>>? _cat;
  Stream<QuerySnapshot<CatModel>>? get cat => _cat;

  Future<void> getCat() async {
    var response = _catRepository.getCatData();
    _cat = response;
    notifyListeners();
  }
}
