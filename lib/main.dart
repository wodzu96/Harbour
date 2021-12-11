import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/BusinessCategoriesService.dart';
import 'package:harbour/res/Assets.dart';

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

  final TextEditingController _autocompleteInputController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
                height: MediaQuery.of(context).size.height - 25,
                color: Color(0xffB5DBED),
                child: Row(
                  children: [_leftColumn(), _rightColumn()],
                ))));
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
                _getInputDescription("Wybierz kategorię"),
                Container(height: 20),
                _businessDescription(),
                _getInputDescription("Wpisz opis kategorii")
              ]))
        ]));
  }

  Widget _appInfo() {
    return Image.asset(Assets.banner);
  }

  Widget _appInfoText() {
    return Text(
        "Tekst z wyjaśnieniem co w ogóle możemy w tej app zrobić i jak nam może zajebiście pomóc płacić podatek dochodowy, ale we własnym lokalu.",
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
          decoration: _autocompleteInputDecoration()),
      suggestionsCallback: (pattern) async {
        return BusinessCategoriesService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
            leading: Image.asset(suggestion!.iconPath),
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

  Widget _rightColumn() {
    return Expanded(
        child: Column(children: [
      Container(height: 100),
      Text("Please use filtration to improve searching.",
          style: GoogleFonts.lora(fontSize: 30, fontWeight: FontWeight.w600)),
      Container(
          width: 300,
          padding: EdgeInsets.only(top: 50),
          child: Column(children: [
            _getRangeLabel("Estate’s price"),
          ])),
    ]));
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
      hintText: 'Mobile Number',
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
                fontSize: 10,
                color: Color(0xff1E1E1E))));
  }

  Widget _getRangeLabel(String text) {
    return Container(
      width: double.infinity,
      child: Text(text,
          style: GoogleFonts.lora(fontSize: 23, fontWeight: FontWeight.w600)),
    );
  }

  Widget _getPriceRangeSlider() {
    TextEditingController firstDotController = TextEditingController(text: "20");
    return Row(children: [
      _rangeInput(firstDotController),

    ]);
  }

  Widget _rangeInput(TextEditingController textEditingController) {
    return Container(
        width: 100,
        child: TextField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            decoration: _standardInputDecoration()
                .copyWith(hintText: "Opis działalności"),
            style: GoogleFonts.montserrat(color: Colors.black)));
  }
}
