import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'api_exceptions.dart';
class HTTPClient {
  static final HTTPClient _singleton = HTTPClient();

  static HTTPClient get instance => _singleton;

  final String baseURL = 'https://jsonblob.com/api/jsonBlob/';

  Future<dynamic> fetchData(String url, Map<String, String> headersType,
      {Map<String, String>? params}) async {
    dynamic responseJson;

    final String uri =
        baseURL + url + ((params != null) ? queryParameters(params) : '');
    final Uri myUri = Uri.parse(uri);
    print(uri);
    try {
      final http.Response response = await http.get(myUri, headers: headersType);
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('Fetch Data Exception');
    }
    return responseJson;
  }

  String queryParameters(Map<String, dynamic> params) {
    if (params != null) {
      final Uri jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  dynamic _returnResponse(http.Response response) async {
    print(response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        try {
          final dynamic responseJson =
          json.decode(utf8.decode(response.bodyBytes));
          return responseJson ?? '';
        } catch (e) {
          return;
        }
        break;
      case 201:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        final dynamic responseJson = json.decode(response.body.toString());
        throw BadRequestValidationException.fromJson(responseJson);
      case 401:
        final dynamic responseJson = json.decode(response.body.toString());
        throw BadRequestValidationException.fromJson(responseJson,
            code: response.statusCode);
        break;
      case 403:
        throw UnauthorisedException(response.body.toString());
        break;
      case 404:
        final dynamic responseJson = json.decode(response.body.toString());
        throw BadRequestValidationException.fromJson(responseJson,
            code: response.statusCode);
        break;
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}