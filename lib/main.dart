import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:harbour/BusinessCategoriesService.dart';
import 'package:harbour/map_screen.dart';
import 'package:harbour/models/Location.dart';

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
      home: MapScreen(
        locations: Location.mockMyShitUp(),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          children: [_localizationColumn(context), _detailsColumn(context)],
        ));
  }

  Widget _localizationColumn(BuildContext context) {
    return Container(
        width: 300,
        child: Column(children: [
          Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: _autocomplete()),
          Expanded(child: Container(color: Color(0xFF0d3225)))
        ]));
  }

  Widget _detailsColumn(BuildContext context) {
    return Expanded(child: Container(color: Color(0xFFaf0a0a)));
  }

  Widget _autocomplete() {
    return TypeAheadField<PKDData?>(
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(border: OutlineInputBorder())),
      suggestionsCallback: (pattern) async {
        return BusinessCategoriesService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
            leading: suggestion!.icon, title: Text(suggestion.name));
      },
      onSuggestionSelected: (suggestion) {},
    );
  }
}
