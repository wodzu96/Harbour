import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final double price;
  final String description;
  final double size;
  final int rooms;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final List<LocationFeature> features;

  Location({
    required this.price,
    required this.description,
    required this.size,
    required this.rooms,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.features,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        price: json["price"],
        description: json["description"],
        size: json["size"],
        rooms: json["rooms_n"],
        imageUrl: json["foto_url"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        features: List<LocationFeature>.from(
          json["features"].map((x) => LocationFeature.fromJson(x)),
        ),
      );

  Marker toMarker() => Marker(
        markerId: MarkerId('$latitude$longitude'),
        position: LatLng(this.latitude, this.longitude),
      );
}

class LocationFeature {
  final double value;
  final String name;

  LocationFeature({
    required this.value,
    required this.name,
  });

  factory LocationFeature.fromJson(Map<String, dynamic> json) =>
      LocationFeature(
        value: json["value"],
        name: json["name"],
      );
}
