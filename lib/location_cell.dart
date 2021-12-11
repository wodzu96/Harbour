import 'package:flutter/material.dart';
import 'package:harbour/models/Location.dart';

class LocationCell extends StatelessWidget {
  final Location _location;
  final Function(Location) _onTap;

  const LocationCell({
    Key? key,
    required Location location,
    required Function(Location) onTap,
  })  : _location = location,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _onTap(_location),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _image(context),
            _textColumn(context),
          ],
        ),
      );

  Widget _image(BuildContext context) => Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: 128,
          height: 64,
          child: Image.network(_location.imageUrl),
        ),
      );

  Widget _textColumn(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _descriptionText(context),
          SizedBox(
            height: 16,
          ),
          _priceText(context)
        ],
      );

  Widget _descriptionText(BuildContext context) => Text(_location.description);

  Widget _priceText(BuildContext context) => Text(_location.price.toString());
}
