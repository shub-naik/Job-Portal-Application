import 'package:JobPortal/SelectRole.dart';
import 'package:flutter/material.dart';

import 'app_translations.dart';
import 'application.dart';

class LanguageSelcectionScreen extends StatefulWidget {
  @override
  _LanguageSelcectionScreenState createState() =>
      _LanguageSelcectionScreenState();
}

class _LanguageSelcectionScreenState extends State<LanguageSelcectionScreen> {

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
  };

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["Hindi"]));
    onLocaleChange(Locale(languagesMap["Marathi"]));
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  void _select(String language) {
    print("dd " + language);
    onLocaleChange(Locale(languagesMap[language]));
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    Future<bool> _onbackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Do u really want to exit ?"),
          actions: <Widget>[
            OutlineButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No")),
            OutlineButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Yes"))
          ],
        ),
      );
    }

    Widget CustomButton(String btnValue) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(40),
            side: new BorderSide(color: Colors.red),
          ),
          onPressed: () {
            _select(btnValue);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SelectRole()));
          },
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Text(
              '$btnValue',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.pinkAccent,
              ),
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text('Language Selection Section'),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomButton("English"),
                CustomButton("Hindi"),
                CustomButton("Marathi"),
//                CustomButton("Bengali"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
