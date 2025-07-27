import 'package:flutter/material.dart';
import '../core/services/api_service.dart';

class PredictionProvider extends ChangeNotifier {
  double? result;
  String? error;

  Future<void> predict(Map<String, dynamic> inputData) async {
    try {
      error = null;
      result = await ApiService.predict(inputData);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      result = null;
      notifyListeners();
    }
  }
}