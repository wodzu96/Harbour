import 'package:harbour/models/Location.dart';

class LocationResponse {
  final List<Location> realEstates;

  LocationResponse({
    required this.realEstates,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        realEstates: List<Location>.from(
          json['real_estates'].map((x) => Location.fromJson(x)),
        ),
      );
}
