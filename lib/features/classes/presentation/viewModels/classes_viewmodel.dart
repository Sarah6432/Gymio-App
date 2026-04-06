import 'package:flutter/material.dart';
import 'package:gymio/features/classes/data/datasources/classes_datasource.dart';
import 'package:gymio/features/classes/data/models/classes_model.dart';

class ClassesViewmodel extends ChangeNotifier {
  final _repo = AulasRemoteDatasource();
  List<AulaModel> aulas = [];
  bool loading = true;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      aulas = await _repo.fetchAll();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
