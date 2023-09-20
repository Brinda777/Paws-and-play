import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/catModel.dart';
import '../repositories/CatRepository.dart';

class SingleCatViewModel with ChangeNotifier {
  CatRepository _catRepository = CatRepository();
  CatModel? _cat = CatModel();
  CatModel? get cat => _cat;

  Future<void> getDogs(String catId) async {
    _cat = CatModel();
    notifyListeners();
    try {
      var response = await _catRepository.getOneCat(catId);
      _cat = response.data();
      notifyListeners();
    } catch (e) {
      _cat = null;
      notifyListeners();
    }
  }

  Future<void> addProduct(CatModel cat) async {
    try {
      var response = await _catRepository.addCats(catModel: cat);
    } catch (e) {
      notifyListeners();
    }
  }
}
