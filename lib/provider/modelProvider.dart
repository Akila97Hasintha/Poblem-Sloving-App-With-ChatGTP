import 'package:chat_gtp_app/services/api_services.dart';
import 'package:flutter/cupertino.dart';

import '../models/models_model.dart';

class ModelsProvider with ChangeNotifier{

  String? currentModel ;

  String? get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel (String newModel){
    currentModel = newModel;
    notifyListeners();
  }
  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}