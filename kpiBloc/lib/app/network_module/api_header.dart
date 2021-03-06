import 'dart:io';

/// ApiHeader
///
/// helper class where we define different types of headers
/// that we will send in our requests
enum ApiHeader {
  appJson
}

class ApiHeaderHelper {
  static Future<Map<String, String>> getValue(ApiHeader path) async {

    switch (path) {
      case ApiHeader.appJson:
        return <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        };
      default:
        return <String, String>{'': ''};
    }
  }
}