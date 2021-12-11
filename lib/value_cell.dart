import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/models/Location.dart';

class ValueCell extends StatelessWidget {
  final String _title;
  final String? _value;

  const ValueCell({
    Key? key,
    required String title,
    required String? value,
  })  : _title = title,
        _value = value,
        super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
          child: Column(
        children: [
          _titleText(context),
          SizedBox(height: 8),
          _valueText(context),
        ],
      ));

  Widget _titleText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: GoogleFonts.lora(
              fontWeight: FontWeight.w600,
            ).fontFamily,
            fontSize: 17,
          ),
        ),
      );

  Widget _valueText(BuildContext context) => Text(
        _value ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: GoogleFonts.lora(
            fontWeight: FontWeight.w500,
          ).fontFamily,
          fontSize: 36,
        ),
      );
}
