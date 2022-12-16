import 'dart:convert';

import 'package:http/http.dart' as http;

class ReturnResponse {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw json.decode(response.body)['info'];
      case 401:
        throw json.decode(response.body)['info'];
      case 404:
        throw json.decode(response.body)['info'];
      case 500:
        throw json.decode(response.body)['info'];
      default:
        throw "Error accourded while communicating with server with status code ${response.statusCode}";
    }
  }
}
