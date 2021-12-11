// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CustomRangeSlider extends StatefulWidget {
//   const CustomRangeSlider({Key? key,
//     required this.startValue,
//     required this.endValue,
//     required this.minValue,
//     required this.maxValue,
//     required this.onFirstValueChanged,
//     required this.onSecondValueChanged})
//       : super(key: key);
//
//   final int startValue;
//   final int endValue;
//   final int maxValue;
//   final int minValue;
//   final ChangeValueCallback onFirstValueChanged;
//   final ChangeValueCallback onSecondValueChanged;
//
//   @override
//   State<CustomRangeSlider> createState() => _CustomRangeSliderState();
// }
//
// class _CustomRangeSliderState extends State<CustomRangeSlider> {
//   final TextEditingController _firstDotController = TextEditingController();
//   final TextEditingController _secondDotController = TextEditingController();
//   int startValue = 0;
//   int endValue = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     startValue = widget.startValue;
//     endValue = widget.endValue;
//
//     _firstDotController.addListener(() {
//       _onFirstValueChanged(int.parse(_firstDotController.text));
//     });
//     _secondDotController.addListener(() {
//       _onSecondValueChanged(int.parse(_secondDotController.text));
//     });
//   }
//
//   _onFirstValueChanged(int value) {
//     if(value != startValue) {
//       widget.onFirstValueChanged(value);
//       setState(() {
//         startValue = value;
//       });
//     }
//   }
//
//   _onSecondValueChanged(int value) {
//     if(value != endValue) {
//       widget.onSecondValueChanged(value);
//       setState(() {
//         endValue = value;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _firstDotController.text = startValue.toString();
//     _secondDotController.text = endValue.toString();
//     return _getPriceRangeSlider();
//   }
//
//   Widget _getPriceRangeSlider() {
//     return Row(children: [
//       _rangeInput(_firstDotController),
//       Expanded(child:
//       RangeSlider(
//           values: RangeValues(
//               startValue.toDouble(), endValue.toDouble()),
//           max: widget.maxValue.toDouble(),
//           min: widget.minValue.toDouble(),
//           divisions: 50,
//           onChanged: (RangeValues values) {
//             if (startValue.toInt() != values.start) {
//               _onFirstValueChanged(values.start.toInt());
//             }
//             if (endValue.toInt() != values.end) {
//               _onSecondValueChanged(values.end.toInt());
//             }
//           })),
//       _rangeInput(_secondDotController)
//     ]);
//   }
//
//
//
//   InputDecoration _standardInputDecoration() {
//     return InputDecoration(
//       contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15),
//       focusedBorder: OutlineInputBorder(
//         gapPadding: 0.0,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         gapPadding: 0.0,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
//       ),
//     );
//   }
// }
//
// typedef ChangeValueCallback = void Function(int value);
