import 'dart:convert';

import 'package:book_my_massage/helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../model/massage_centres_model.dart';

class DataUtils {
  static const String _jsonPath = 'assets/data.json';

  static Future<List<MassageCentre>> _loadJsonData() async {
    String jsonData = await rootBundle.loadString(_jsonPath);
    final List<dynamic> jsonList = json.decode(jsonData);
    debugPrint('jsoList: $jsonList');
    return jsonList.map((json) => MassageCentre.fromMap(json)).toList();
  }

  static Future<List<MassageCentre>> loadDataFromDb() async {
    final massageList = await _loadJsonData();
    debugPrint('messsageList:: $massageList');
    await DatabaseHelper.instance.saveMassages(massageList);
    return await DatabaseHelper.instance.getAllMassages();
  }
}
