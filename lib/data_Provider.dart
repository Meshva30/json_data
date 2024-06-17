
import 'package:flutter/cupertino.dart';

import 'data_model.dart';

class DataProvider extends ChangeNotifier {
  Map data = {};
  DataModel? dataModel;

  DataProvider() {
    // convertJsonToString();
  }

  void convertToDataModel(Map data) {
    dataModel = DataModel.fromJson(data);
  }
}
