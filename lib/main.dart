import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/BusinessCategoriesService.dart';
import 'package:harbour/res/Assets.dart';
import 'package:harbour/widget/RangeSlider.dart';

import 'api/LocationRequest.dart';
import 'api/api.dart';
import 'map_screen.dart';
import 'models/Location.dart';
import 'models/PKDData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final TextEditingController _minPriceInputController =
  TextEditingController(text: "20");
  final TextEditingController _maxPriceInputController =
  TextEditingController(text: "100000");
  final TextEditingController _minEstateAreaInputController =
  TextEditingController(text: "20");
  final TextEditingController _maxEstateAreaInputController =
  TextEditingController(text: "100000");
  final TextEditingController _minRoomsNumberAreaInputController =
  TextEditingController(text: "1");
  final TextEditingController _maxRoomsNumberInputController =
  TextEditingController(text: "8");
  final TextEditingController _autocompleteInputController =
  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressHUD(
            child: Builder(
                builder: (context) =>
                    SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height - 24,
                            color: Color(0xffB5DBED),
                            child: Row(
                              children: [_leftColumn(), _rightColumn(context)],
                            ))))));
  }

  Widget _leftColumn() {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xffF2F8FA),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(50.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 13,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        width: 400,
        child: Column(children: [
          _appInfo(),
          Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 8, top: 30),
              child: Column(children: [
                _appInfoText(),
                Container(height: 40),
                _autocomplete(),
                _getInputDescription("Please find the most related category to your business."),
                Container(height: 20),
                _businessDescription(),
                _getInputDescription("The description helps to find most related estate’s characteristic. Feel free to modify text in this box.")
              ]))
        ]));
  }

  Widget _appInfo() {
    return Image.asset(Assets.banner);
  }

  Widget _appInfoText() {
    return Text(
        "This app is helping real estate brokers find the most suitable locations for their clients’ businesses.  By choosing category and adjusting few filters you’ll find the one and only place for them.",
        style: GoogleFonts.lora(
            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black));
  }

  Widget _autocomplete() {
    return Container(
        child: TypeAheadField<PKDData?>(
          suggestionsBoxDecoration: SuggestionsBoxDecoration(elevation: 1.0),
          textFieldConfiguration: TextFieldConfiguration(
              controller: this._autocompleteInputController,
              style: GoogleFonts.montserrat(color: Colors.black),
              scrollPadding: EdgeInsets.only(bottom: 190),
              decoration: _autocompleteInputDecoration()),
          suggestionsCallback: (pattern) async {
            return BusinessCategoriesService.getSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
                leading: Image.asset(suggestion!.iconPath, width: 20, height: 20),
                title: Text(suggestion.name));
          },
          onSuggestionSelected: (suggestion) {
            this._autocompleteInputController.text = suggestion!.name;
            this._descriptionController.text = suggestion.description;
          },
        ));
  }

  Widget _businessDescription() {
    return TextField(
        keyboardType: TextInputType.multiline,
        controller: this._descriptionController,
        scrollPadding: EdgeInsets.only(bottom: 128),
        decoration:
        _standardInputDecoration().copyWith(hintText: "Opis działalności"),
        minLines: 3,
        style: GoogleFonts.montserrat(color: Colors.black),
        maxLines: 30);
  }

  Widget _rightColumn(BuildContext context) {
    return Expanded(
        child: Column(children: [
          Container(height: 100),
          Text("Please use filtration to improve searching.",
              style: GoogleFonts.lora(
                  fontSize: 30, fontWeight: FontWeight.w600)),
          Container(
              width: 400,
              padding: EdgeInsets.only(top: 50),
              child: Column(children: [
                _filterCell("Estate’s price", _minPriceInputController,
                    _maxPriceInputController),
                Container(height: 50),
                _filterCell("Estate’s area", _minEstateAreaInputController,
                    _maxEstateAreaInputController),
                Container(height: 50),
                _filterCell(
                    "Number of rooms", _minRoomsNumberAreaInputController,
                    _maxRoomsNumberInputController),
                Container(height: 50),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                          backgroundColor:
                          MaterialStateProperty.all(Color(0xff1D3851))),
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);
                        progress?.showWithText('Loading...');
                        final locations = getLocationRequest();
                        final response = await Api().getLocations(getLocationRequest());
                        if(response != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                MapScreen(locations: response.realEstates)),
                          );
                        }
                        progress?.dismiss();
                      },
                      child: Text('SEARCH', style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700)),
                    ))
              ])),
        ]));
  }


  Widget _filterCell(String name,
      TextEditingController minValueEditingController,
      TextEditingController maxValueEditingController) {
    return Column(children: [
      _getRangeLabel(name),
      Container(height: 10),
      Row(children: [
        Container(width: 20),
        _fromToLabel("from:"),
        Container(width: 20),
        _rangeInput(minValueEditingController),
        Container(width: 40),
        _fromToLabel("to:"),
        Container(width: 20),
        _rangeInput(maxValueEditingController)
      ])
    ]);
  }

  Widget _fromToLabel(String data) {
    return Text(data,
        style:
        GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 15));
  }

  Widget _rangeInput(TextEditingController textEditingController) {
    return Container(
        width: 100,
        child: TextField(
            textAlign: TextAlign.center,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            decoration: _standardRangeDecoration()
                .copyWith(hintText: "Opis działalności"),
            style: GoogleFonts.montserrat(color: Colors.black)));
  }

  InputDecoration _standardRangeDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
      ),
    );
  }

  InputDecoration _autocompleteInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 15),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
      ),
      hintText: 'Input business category...',
    );
  }

  InputDecoration _standardInputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Color(0xff406D86), width: 2.0),
      ),
      hintText: 'Mobile Number',
    );
  }

  Widget _getInputDescription(String text) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 10, top: 4),
        child: Text(text,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontSize: 11,
                color: Color(0xff1E1E1E))));
  }

  Widget _getRangeLabel(String text) {
    return Container(
      width: double.infinity,
      child: Text(text,
          style: GoogleFonts.lora(fontSize: 23, fontWeight: FontWeight.w600)),
    );
  }

  LocationRequest getLocationRequest() {
    return LocationRequest(
        priceMax: int.parse(_maxPriceInputController.text),
        priceMin: int.parse(_minPriceInputController.text),
        roomsMax: int.parse(_maxRoomsNumberInputController.text),
        roomsMin: int.parse(_minRoomsNumberAreaInputController.text),
        sizeMin: int.parse(_minEstateAreaInputController.text),
        sizeMax: int.parse(_maxEstateAreaInputController.text),
        text: _descriptionController.text
    );
  }
}

typedef ChangeValueCallback = void Function(int value);
