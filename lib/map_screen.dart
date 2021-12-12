import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:harbour/filter_popup.dart';
import 'package:harbour/location_cell.dart';
import 'package:harbour/models/Location.dart';
import 'package:harbour/norm_value_cell.dart';
import 'package:harbour/res/Assets.dart';
import 'package:harbour/value_cell.dart';

class MapScreen extends StatefulWidget {
  final List<Location> locations;

  MapScreen({Key? key, required this.locations}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late Location _selectedLocation;
  late Map<String, double> _featureToRate;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.locations.first;
    _featureToRate = Map.fromIterable(
      _selectedLocation.features,
      key: (feature) => feature.name,
      value: (value) => 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(context),
      ),
      backgroundColor: Color(0xFFF2F8FA),
    );
  }

  Widget _body(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _entriesColumn(context),
          ),
          VerticalDivider(
            width: 2,
            color: Color(0xFF1D3851),
            thickness: 2,
          ),
          Expanded(
            flex: 2,
            child: _mapColumn(context),
          ),
        ],
      );

  Widget _entriesColumn(BuildContext context) => Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _estatesHeader(context),
              Divider(
                height: 2,
                color: Color(0xFF1D3851),
                thickness: 2,
              ),
              Expanded(child: _estatesList(context))
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: FloatingActionButton(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Image.asset(Assets.sort),
                ),
                backgroundColor: Color(0xFF1D3851),
                onPressed: _onFilterButtonPressed,
              ),
            ),
          )
        ],
      );

  void _onFilterButtonPressed() async {
    Map<String, double>? result = await showDialog(
      context: context,
      builder: (context) => FilterPopup(
        featureToRate: _featureToRate,
      ),
    );

    log(result.toString());
    print(result.toString());
  }

  Widget _estatesHeader(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Estates',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontFamily: GoogleFonts.lora(
                fontWeight: FontWeight.w500,
              ).fontFamily,
              fontSize: 52,
            ),
          ),
        ),
      );

  Widget _estatesList(BuildContext context) => ListView.separated(
        padding: EdgeInsets.only(bottom: 88),
        itemBuilder: (context, positon) => LocationCell(
          location: widget.locations[positon],
          isSelected: widget.locations[positon] == _selectedLocation,
          onTap: (location) => _onLocationTap(context, location),
        ),
        separatorBuilder: _estatesSeparator,
        itemCount: widget.locations.length,
      );

  Widget _estatesSeparator(BuildContext context, int position) {
    int indexOfSelected = widget.locations.indexOf(_selectedLocation);

    if (position == indexOfSelected || position + 1 == indexOfSelected) {
      return SizedBox(height: 2);
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Divider(
          height: 2,
          thickness: 2,
          color: Color(0xFF406D86),
        ),
      );
    }
  }

  void _onLocationTap(BuildContext context, Location location) {
    setState(() {
      _selectedLocation = location;
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(
            location.latitude,
            location.longitude,
          ),
          17));
    });
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
          target: LatLng(
            _selectedLocation.latitude,
            _selectedLocation.longitude,
          ),
          zoom: 12.0,
        ),
    mapType: MapType.hybrid,
        myLocationButtonEnabled: false,
        markers: widget.locations.map((e) => e.toMarker()).toSet(),
      );

  Widget _indicatorsTable(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 62),
              ValueCell(
                  title: 'Estate price',
                  value: _selectedLocation.price.toString()),
              SizedBox(width: 41),
              ValueCell(
                  title: 'Estate’s area',
                  value: _selectedLocation.size.toString()),
              SizedBox(width: 41),
              ValueCell(
                  title: 'Number of rooms',
                  value: _selectedLocation.rooms.toString()),
              SizedBox(width: 62),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44),
            child: Divider(
              height: 2,
              thickness: 2,
              color: Color(0xFF406D86),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 62),
              NormValueCell(
                title: _selectedLocation.features[0].name,
                value: _selectedLocation.features[0].value,
              ),
              SizedBox(width: 41),
              NormValueCell(
                title: _selectedLocation.features[1].name,
                value: _selectedLocation.features[1].value,
              ),
              SizedBox(width: 41),
              NormValueCell(
                title: _selectedLocation.features[2].name,
                value: _selectedLocation.features[2].value,
              ),
              SizedBox(width: 62),
            ],
          )
        ],
      );
}
