import 'dart:io';

import 'package:final_project/models/workspace/workspace.dart';
import 'package:final_project/models/workspace/workspace_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants/base_url.dart';
import '../../../utils/return_response.dart';

class WorkspaceApi {
  final ReturnResponse returnResponse = ReturnResponse();
  Future<List<WorkspaceModel>> getRequestWorkSpace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("$baseUrl/api/workspace"),
      headers: {
        "Authorization": "Bearer ${prefs.getString('token')}",
        "Content-Type": "application/json"
      },
    );

    try {
      if (response.statusCode == 200) {
        return (returnResponse.returnResponse(response)['data'] as List)
            .map((e) => WorkspaceModel.fromJson(e))
            .toList();
      }
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<Workspace> getWorkspaceById(String workspaceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse("$baseUrl/api/workspace/$workspaceId"),
      headers: {
        "Authorization": "Bearer ${prefs.getString('token')}",
        "Content-Type": "application/json"
      },
    );

    try {
      if (response.statusCode == 200) {
        final Workspace workspace =
            Workspace.fromJson(returnResponse.returnResponse(response)['data']);

        return workspace;
      }
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> postWorkspace(
      {required String workspaceName,
      required String workspaceDescription}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse("$baseUrl/api/workspace"),
      body: {'name': workspaceName, 'description': workspaceDescription},
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> updateWorkspace(
      {required String workspaceName,
      required String workspaceDescription,
      required String workspaceId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.put(
      Uri.parse("$baseUrl/api/workspace/$workspaceId"),
      body: {
        'name': workspaceName,
        'description': workspaceDescription,
        "visibility": "team"
      },
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> deleteWorkspace(String workspaceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse("$baseUrl/api/workspace/$workspaceId"),
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> addTeamWorkspace(
      {required String email, required String workspaceId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse("$baseUrl/api/workspace/invite/$workspaceId"),
      body: {'email': email},
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> removeTeamWorkspace(
      {required String email, required String workspaceId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse("$baseUrl/api/workspace/remove/$workspaceId"),
      body: {'email': email},
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }
}
