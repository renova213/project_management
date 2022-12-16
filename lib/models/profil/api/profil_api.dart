import 'dart:io';

import 'package:final_project/constants/base_url.dart';
import 'package:final_project/models/profil/profil_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/return_response.dart';

class ProfilApi {
  final ReturnResponse returnResponse = ReturnResponse();
  Future<ProfilModel> getProfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("$baseUrl/api/profile"),
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      if (response.statusCode == 200) {
        return ProfilModel.fromJson(
            returnResponse.returnResponse(response)['data']['user']);
      }
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }
}
