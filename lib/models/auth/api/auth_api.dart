import 'dart:convert';
import 'dart:io';

import 'package:final_project/constants/base_url.dart';
import 'package:final_project/models/auth/login_model.dart';
import 'package:final_project/models/auth/register_model.dart';
import 'package:final_project/utils/return_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  final ReturnResponse returnResponse = ReturnResponse();

  Future<dynamic> loginRequest(LoginModel login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse("$baseUrl/api/auth/login"),
        body: login.toJson());

    try {
      if (response.statusCode == 200) {
        prefs.setString(
          'token',
          json.decode(response.body)['data']['access_token'],
        );
        prefs.setString(
            'email', json.decode(response.body)['data']['user']['email']);
        prefs.setString(
            'username', json.decode(response.body)['data']['user']['username']);
        return returnResponse.returnResponse(response);
      }
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> registerRequest(RegisterModel register) async {
    final response = await http.post(Uri.parse("$baseUrl/api/auth/register"),
        body: register.toJson());

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> logoutRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/logout"),
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }

  Future<dynamic> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/refresh"),
      headers: {"Authorization": "Bearer ${prefs.getString('token')}"},
    );

    try {
      if (response.statusCode == 200) {
        prefs.setString(
          'token',
          json.decode(response.body)['data']['access_token'],
        );
        prefs.setString(
            'email', json.decode(response.body)['data']['user']['email']);
        prefs.setString(
            'username', json.decode(response.body)['data']['user']['username']);
        return returnResponse.returnResponse(response);
      }
      return returnResponse.returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
  }
}
