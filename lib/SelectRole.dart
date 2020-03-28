import 'package:flutter/material.dart';

class SelectRole extends StatefulWidget {
  @override
  _SelectRoleState createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('Select Your Role'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                highlightColor: Colors.pinkAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40),
                  side: new BorderSide(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/employer_section');
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Text(
                    'I want to hire',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40),
                  side: new BorderSide(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/CandidateSignUpSection');
                },
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Text(
                    'I am a candidate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
