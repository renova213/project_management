import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/base_url.dart';
import '../../../utils/return_response.dart';

class TaskApi {
  final ReturnResponse returnResponse = ReturnResponse();

  Future<dynamic> postTask(
      {required String workspaceId,
      required String title,
      required String description}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.post(Uri.parse("$baseUrl/api/workspace/task"), headers: {
      "Authorization": "Bearer ${prefs.getString('token')}"
    }, body: {
      "workspace_id": workspaceId,
      "title": title,
      "description": description,
      "status": "1"
    });

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> putTask(
      {required int id,
      required String title,
      required String description,
      required String progress}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.put(Uri.parse("$baseUrl/api/workspace/task/$id"), headers: {
      "Authorization": "Bearer ${prefs.getString('token')}"
    }, body: {
      "title": title,
      "description": description,
      "status": "0",
      "label": "feature",
      "milestone": "v.1",
      "progress": progress
    });

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }
}
