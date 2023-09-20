import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/AdoptModel.dart';
import '../repositories/adopt_cat_repo.dart';

class AdoptionCatViewModel with ChangeNotifier {
  AdoptionCatRepo _adoptionRepo = AdoptionCatRepo();
  Stream<QuerySnapshot<AdoptionModel>>? _adoptCat;
  //_underscore rakheko variable aaru cls le use garna mildain a
  Stream<QuerySnapshot<AdoptionModel>>? get adoptCat => _adoptCat;

  Future<void> getAdopt() async {
    var response = _adoptionRepo.getAdopts();
    _adoptCat = response;
    notifyListeners();
  }

  Future<void> deleteAdopt(String id) async {
    await _adoptionRepo.deleteAdopt(id);
    notifyListeners();
  }
}
