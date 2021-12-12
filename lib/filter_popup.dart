import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/models/Location.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterPopup extends StatefulWidget {
  final Map<String, double> _featureToRate;

  FilterPopup({
    Key? key,
    required Map<String, double> featureToRate,
  })  : _featureToRate = featureToRate,
        super(key: key);

  @override
  State<FilterPopup> createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  late Map<String, double> _featureToRate;

  @override
  void initState() {
    super.initState();
    _featureToRate = widget._featureToRate;
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xFFF2F8FA),
          child: SizedBox(
            height: 512,
            width: 756,
            child: _content(context),
          ),
        ),
      );

  Widget _content(BuildContext context) => Column(
        children: [
          _header(context),
          Expanded(
              child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, positon) => _locationFeatureCell(
                context, _featureToRate.entries.elementAt(positon)),
            separatorBuilder: (context, position) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                height: 2,
                thickness: 2,
                color: Color(0xFF406D86),
              ),
            ),
            itemCount: _featureToRate.entries.length,
          )),
          _footer(context),
        ],
      );

  Widget _header(BuildContext context) => Container(
        height: 64,
        decoration: BoxDecoration(
          color: Color(0xFF1D3851),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Sorting',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFFF2F8FA),
                  fontFamily: GoogleFonts.lora(
                    fontWeight: FontWeight.w500,
                  ).fontFamily,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      );

  Widget _footer(BuildContext context) => Container(
        height: 64,
        decoration: BoxDecoration(
          color: Color(0xFF1D3851),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: TextButton(
                onPressed: _onApplyButtonPressed,
                child: Text(
                  'APPLY',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Color(0xFFF2F8FA),
                    fontFamily: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                    ).fontFamily,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  void _onApplyButtonPressed() {
    Navigator.of(context).pop(_featureToRate);
  }

  Widget _locationFeatureCell(
          BuildContext context, MapEntry<String, double> featureToRate) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            _featureText(context, featureToRate),
            _featureSlider(context, featureToRate),
          ],
        ),
      );

  Widget _featureText(
          BuildContext context, MapEntry<String, double> featureToRate) =>
      Expanded(
          child: Text(
        featureToRate.key,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color(0xFF000000),
          fontFamily: GoogleFonts.lora(
            fontWeight: FontWeight.w500,
          ).fontFamily,
          fontSize: 25,
        ),
      ));

  Widget _featureSlider(
          BuildContext context, MapEntry<String, double> featureToRate) =>
      SizedBox(
        width: 200,
        child: SfSliderTheme(
          data: SfSliderThemeData(
            thumbColor: Color(0xFFD69E45),
            activeTrackColor: Color(0xFFE5CC8E),
            inactiveTrackColor: Color(0xFFE5CC8E),
          ),
          child: SfSlider(
            min: -10,
            max: 10,
            stepSize: 1,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            value: _featureToRate[featureToRate.key]!,
            onChanged: (value) =>
                _onFeatureValueChanged(context, featureToRate, value),
          ),
        ),
      );

  void _onFeatureValueChanged(
    BuildContext context,
    MapEntry<String, double> featureToRate,
    double value,
  ) {
    setState(() {
      _featureToRate[featureToRate.key] = value;
    });
  }
}
