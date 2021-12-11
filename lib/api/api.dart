import 'dart:convert';
import 'dart:developer';

import 'package:harbour/api/LocationResponse.dart';
import 'package:harbour/models/Location.dart';
import 'package:harbour/api/LocationRequest.dart';

import 'package:http/http.dart' as http;

class Api {
  final String apiUrl = 'http://api.url';

  Future<LocationResponse?> getLocations(LocationRequest request) async {
    var url = Uri.parse('$apiUrl/real_estate');
    try {
      http.Response response = await http.post(url, body: request.toJson());
      return LocationResponse.fromJson(jsonDecode(response.body));
    } on Exception catch (exception) {
      log('Wyjebało się API: $exception', level: 2000);
      return null;
    }
  }
}
