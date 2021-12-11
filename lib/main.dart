import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbour/BusinessCategoriesService.dart';
import 'package:harbour/map_screen.dart';
import 'package:harbour/models/Location.dart';
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

Widget _mapScreen() => MapScreen(
      locations: [
        Location(
          price: 1,
          description:
              'wejfnwjencseojnfsoenfoisenfoiwenfoiwneio oifwenfoinewoinf wioenfoi wneiofn ewoinfoi nweiofnoiwenoifniowenfoinweio newionfiownf',
          size: 34,
          rooms: 2,
          imageUrl:
              'https://media.istockphoto.com/photos/low-angle-of-tall-building-in-manhattan-picture-id1291177121',
          latitude: 21,
          longitude: 37,
          features: [
            LocationFeature(
              value: 1,
              name: 'Number of gay people',
            ),
            LocationFeature(
              value: 0.8,
              name: 'Percent of barber users',
            ),
            LocationFeature(
              value: 0.1,
              name: 'JS developer happines',
            )
          ],
        ),
        Location(
          price: 1,
          description:
              'wejfnwjencseojnfsoenfoisenfoiwenfoiwneio oifwenfoinewoinf wioenfoi wneiofn ewoinfoi nweiofnoiwenoifniowenfoinweio newionfiownf',
          size: 34,
          rooms: 2,
          imageUrl:
              'https://media.istockphoto.com/photos/low-angle-of-tall-building-in-manhattan-picture-id1291177121',
          latitude: 21,
          longitude: 37,
          features: [
            LocationFeature(
              value: 0.99,
              name: 'Autism',
            ),
            LocationFeature(
              value: 0.3,
              name: 'Cookies',
            ),
            LocationFeature(
              value: 0.10,
              name: 'Cheap weed',
            )
          ],
        ),
        Location(
          price: 1,
          description:
              'wejfnwjencseojnfsoenfoisenfoiwenfoiwneio oifwenfoinewoinf wioenfoi wneiofn ewoinfoi nweiofnoiwenoifniowenfoinweio newionfiownf',
          size: 34,
          rooms: 2,
          imageUrl:
              'https://media.istockphoto.com/photos/low-angle-of-tall-building-in-manhattan-picture-id1291177121',
          latitude: 21,
          longitude: 37,
          features: [
            LocationFeature(
              value: 0.99,
              name: 'Autism',
            ),
            LocationFeature(
              value: 0.3,
              name: 'Cookies',
            ),
            LocationFeature(
              value: 0.10,
              name: 'Cheap weed',
            )
          ],
        ),
        Location(
          price: 1,
          description:
              'wejfnwjencseojnfsoenfoisenfoiwenfoiwneio oifwenfoinewoinf wioenfoi wneiofn ewoinfoi nweiofnoiwenoifniowenfoinweio newionfiownf',
          size: 34,
          rooms: 2,
          imageUrl:
              'https://media.istockphoto.com/photos/low-angle-of-tall-building-in-manhattan-picture-id1291177121',
          latitude: 21,
          longitude: 37,
          features: [
            LocationFeature(
              value: 0.99,
              name: 'Autism',
            ),
            LocationFeature(
              value: 0.3,
              name: 'Cookies',
            ),
            LocationFeature(
              value: 0.10,
              name: 'Cheap weed',
            )
          ],
        ),
        Location(
          price: 1,
          description:
              'wejfnwjencseojnfsoenfoisenfoiwenfoiwneio oifwenfoinewoinf wioenfoi wneiofn ewoinfoi nweiofnoiwenoifniowenfoinweio newionfiownf',
          size: 34,
          rooms: 2,
          imageUrl:
              'https://media.istockphoto.com/photos/low-angle-of-tall-building-in-manhattan-picture-id1291177121',
          latitude: 21,
          longitude: 37,
          features: [
            LocationFeature(
              value: 0.99,
              name: 'Autism',
            ),
            LocationFeature(
              value: 0.3,
              name: 'Cookies',
            ),
            LocationFeature(
              value: 0.10,
              name: 'Cheap weed',
            )
          ],
        ),
      ],
    );

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
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 25),
            color: Color(0xffE5E5E5),
            child: Row(
              children: [_leftColumn(), _detailsColumn(context)],
            )));
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
                _autocomplete()
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
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._typeAheadController,
          style: GoogleFonts.montserrat(color: Colors.black),
          decoration: InputDecoration(
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
          )),
      suggestionsCallback: (pattern) async {
        return BusinessCategoriesService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
            leading: Image.asset(suggestion!.iconPath),
            title: Text(suggestion.name));
      },
      onSuggestionSelected: (suggestion) {
        this._typeAheadController.text = suggestion!.name;
      },
    ));
  }

  Widget _detailsColumn(BuildContext context) {
    return Container();
  }
}
