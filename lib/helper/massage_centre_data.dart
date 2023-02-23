import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../model/massage_centres_model.dart';

class MassageCentre {
  static const String _jsonPath = 'assets/data.json';

  Future<List<MassageCentres>> loadJsonData() async {
    String jsonData = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonList = json.decode(jsonData);
    return jsonList.map((json) => MassageCentres.fromJson(json)).toList();
  }
}
