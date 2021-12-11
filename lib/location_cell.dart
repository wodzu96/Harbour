import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/models/Location.dart';

class LocationCell extends StatelessWidget {
  final Location _location;
  final bool _isSelected;
  final Function(Location) _onTap;

  const LocationCell({
    Key? key,
    required Location location,
    required bool isSelected,
    required Function(Location) onTap,
  })  : _location = location,
        _isSelected = isSelected,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: _isSelected ? Color(0xFF406D86) : Color(0xFFF2F8FA),
        child: InkWell(
          onTap: () => _onTap(_location),
          child: Padding(
            padding: EdgeInsets.only(left: 32, top: 12, bottom: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(context),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: _textColumn(context),
                )
              ],
            ),
          ),
        ),
      );

  Widget _image(BuildContext context) => Column(
        children: [
          SizedBox(height: 4),
          SizedBox(
            width: 178,
            child: Image.network(
              _location.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      );

  Widget _textColumn(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _priceText(context),
          SizedBox(
            height: 16,
          ),
          _descriptionText(context),
        ],
      );

  Widget _descriptionText(BuildContext context) => Text(
        _location.description,
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _isSelected ? Color(0xFFF2F8FA) : Color(0xFF1E1E1E),
          fontFamily: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
          ).fontFamily,
          fontSize: 16,
        ),
      );

  Widget _priceText(BuildContext context) => Text(
        '${_location.price} PLN',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: _isSelected ? Color(0xFFF2F8FA) : Color(0xFF1E1E1E),
          fontFamily: GoogleFonts.lora(
            fontWeight: FontWeight.w500,
          ).fontFamily,
          fontSize: 25,
        ),
      );
}
