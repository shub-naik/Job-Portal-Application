import 'package:flutter/material.dart';

class LanguageSelcectionScreen extends StatefulWidget {
  @override
  _LanguageSelcectionScreenState createState() =>
      _LanguageSelcectionScreenState();
}

class _LanguageSelcectionScreenState extends State<LanguageSelcectionScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            Navigator.pushNamed(context, '/select_role');
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
                CustomButton("Hindi"),
                CustomButton("English"),
                CustomButton("Marathi"),
                CustomButton("Bengali"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
