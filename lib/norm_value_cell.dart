import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/models/Location.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NormValueCell extends StatelessWidget {
  final String? _title;
  final double? _value;

  const NormValueCell({
    Key? key,
    required String? title,
    required double? value,
  })  : _title = title,
        _value = value ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
          child: Column(
        children: [
          _titleText(context),
          SizedBox(height: 8),
          _valueText(context),
          SizedBox(height: 8),
          _normValueBar(context),
        ],
      ));

  Widget _titleText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          _title ?? '',
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
        _value != null ? '${_value! * 100}%' : '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: GoogleFonts.lora(
            fontWeight: FontWeight.w500,
          ).fontFamily,
          fontSize: 36,
        ),
      );

  Widget _normValueBar(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: 2,
          bottom: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xFF406D86),
        ),
        child: _value != null
            ? LinearPercentIndicator(
                percent: _value!,
                lineHeight: 6,
                animation: true,
                animateFromLastPercent: true,
                progressColor: Color(0xFFD69E45),
                backgroundColor: Color(0xFFB5DBED),
                padding: EdgeInsets.symmetric(horizontal: 6),
              )
            : SizedBox(),
      );
}
