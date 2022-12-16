import 'package:final_project/models/profil/api/profil_api.dart';
import 'package:final_project/models/profil/profil_model.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_state.dart';

class ProfilViewModel extends ChangeNotifier {
  ProfilApi profilApi = ProfilApi();

  late ProfilModel _profil;
  AppState _appState = AppState.loading;

  ProfilModel get profil => _profil;
  AppState get appState => _appState;

  Future<void> getProfil() async {
    try {
      changeAppState(AppState.loading);
      _profil = await profilApi.getProfil();
      changeAppState(AppState.loaded);
    } catch (_) {
      changeAppState(AppState.failure);
      rethrow;
    }
  }

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }
}
