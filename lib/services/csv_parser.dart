import 'dart:math';

import 'package:csv/csv.dart';

import '../models/data_model.dart';

class CsVParser {
  static Future<List<DataModel>> csvToListModel(String data) async {
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(data, eol: "\n");
    List<DataModel> dataList = [];

    double timeStartValue = double.parse(csvTable[1][0].toString()) * 10;
    for (int i = 1; i < csvTable.length; i++){
      double time = double.parse(csvTable[i][0].toString()) * 10;
      DataModel model = DataModel(
        time: roundDouble(time-timeStartValue,2),
        speed: double.parse(csvTable[i][3].toString()),
      );
      dataList.add(model);
    }

    return dataList;
  }

  static double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
