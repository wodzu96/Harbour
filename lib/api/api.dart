import 'dart:convert';
import 'dart:developer';

import 'package:harbour/api/LocationResponse.dart';
import 'package:harbour/models/Location.dart';
import 'package:harbour/api/LocationRequest.dart';

import 'package:http/http.dart' as http;

class Api {
  final String apiUrl = 'http://167.172.177.233:5000';

  Future<LocationResponse?> getLocations(LocationRequest request) async {
    var url = Uri.parse('$apiUrl/real_estates');
    try {
      final body = jsonEncode(request.toJson());
      http.Response response =
          await http.post(url, body: body, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      return LocationResponse.fromJson(jsonDecode(response.body));
    } on Exception catch (exception) {
      log('Popsuło się API: $exception', level: 2000);
      return null;
    }
  }
}
