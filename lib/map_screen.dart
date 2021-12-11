import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:harbour/location_cell.dart';
import 'package:harbour/models/Location.dart';

class MapScreen extends StatefulWidget {
  final List<Location> locations;

  MapScreen({Key? key, required this.locations}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _initialMapPosition = const LatLng(51.7732033, 19.4105532);
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: _body(context));
  }

  Widget _body(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _entriesColumn(context),
          ),
          Expanded(
            flex: 2,
            child: _mapColumn(context),
          ),
        ],
      );

  Widget _entriesColumn(BuildContext context) => ListView(
        children: widget.locations
            .map((e) => LocationCell(
                  location: e,
                  onTap: (location) => _onLocationTap(context, location),
                ))
            .toList(),
      );

  void _onLocationTap(BuildContext context, Location location) {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(
          location.latitude,
          location.longitude,
        ),
        12));
  }

  Widget _mapColumn(BuildContext context) => Column(
        children: [
          Expanded(
            flex: 2,
            child: _map(context),
          ),
          Expanded(
            flex: 1,
            child: _indicatorsTable(context),
          )
        ],
      );

  Widget _map(BuildContext context) => GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialMapPosition,
          zoom: 12.0,
        ),
        markers: widget.locations.map((e) => e.toMarker()).toSet(),
      );

  Widget _indicatorsTable(BuildContext context) => Container(
        color: Colors.amber,
      );
}
