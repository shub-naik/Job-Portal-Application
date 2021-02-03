import 'dart:async';
import 'package:JobPortal/LanguageSelectionContainer.dart';

import 'Candidate_Zone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'EmployerZone.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    void getSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String EmployerEmail = prefs.getString('EmployerEmail');
      String CandidatePhoneNumber = prefs.getString('CandidatePhoneNumber');

      if (EmployerEmail != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Employer_Zone()));
      } else if (CandidatePhoneNumber != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Candidate_Zone()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LanguageSelectionContainer()));
      }
    }

    Timer(Duration(seconds: 4), () => getSharedPreferences());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: BoxDecoration(color: Colors.redAccent),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Mdi.diamondStone, size: 100),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    'HeeraPolish',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Padding(padding: EdgeInsets.all(12)),
                Text("Designed By"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Pragyat IT Solutions Pvt Ltd',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
    ]));
  }
}
