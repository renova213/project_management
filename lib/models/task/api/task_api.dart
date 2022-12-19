import 'dart:io';

import 'package:final_project/models/task/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/base_url.dart';
import '../../../utils/return_response.dart';

class TaskApi {
  final ReturnResponse returnResponse = ReturnResponse();

  Future<TaskModel> getTaskById(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("$baseUrl/api/workspace/task/$taskId"),
      headers: {
        "Authorization": "Bearer ${prefs.getString('token')}",
        "Content-Type": "application/json"
      },
    );

    try {
      if (response.statusCode == 200) {
        final TaskModel workspace =
            TaskModel.fromJson(returnResponse.returnResponse(response)['data']);

        return workspace;
      }
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

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

  Future<dynamic> assignMemberTask(
      {required int userId, required int taskId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
        Uri.parse("$baseUrl/api/workspace/task/assign"),
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
        body: {"user_id": userId.toString(), "task_id": taskId.toString()});

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> deleteAssignMemberTask(
      {required int userId, required int taskId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
        Uri.parse("$baseUrl/api/workspace/task/delete/$taskId"),
        headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
        body: {"user_id": userId.toString()});

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> deleteTask({required int taskId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse("$baseUrl/api/workspace/task/$taskId"),
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );
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
      required String progress,
      required String milestone}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await http.put(Uri.parse("$baseUrl/api/workspace/task/$id"), headers: {
      "Authorization": "Bearer ${prefs.getString('token')}"
    }, body: {
      "title": title,
      "description": description,
      "status": "0",
      "label": "feature",
      "milestone": milestone,
      "progress": progress
    });

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }
}
