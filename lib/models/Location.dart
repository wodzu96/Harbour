import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:harbour/util/random_util.dart';

class Location {
  final double price;
  final String description;
  final double size;
  final int rooms;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final List<LocationFeature> features;

  Location(
    this.price,
    this.description,
    this.size,
    this.rooms,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.features,
  );

  Marker toMarker() => Marker(
        markerId: MarkerId('$latitude$longitude'),
        position: LatLng(this.latitude, this.longitude),
      );

  static List<Location> mockMyShitUp() => [
        Location(
          10,
          'Description',
          48,
          3,
          'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
          RandomUtil.randomLatLng(),
          RandomUtil.randomLatLng(),
          [],
        ),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
        Location(
            10,
            'Description',
            48,
            3,
            'https://imfilter.pl/wp-content/uploads/2020/03/apartment-apartment-building-architecture-building-32RandomUtil.randomLatLng()05.jpg',
            RandomUtil.randomLatLng(),
            RandomUtil.randomLatLng(), []),
      ];
}

class LocationFeature {
  final String value;
  final String name;

  LocationFeature(
    this.value,
    this.name,
  );
}
