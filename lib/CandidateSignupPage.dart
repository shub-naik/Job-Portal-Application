import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import 'CandidateMobileVerification.dart';

class CandidateSignUpSection extends StatefulWidget {
  @override
  _CandidateSignUpSection createState() => _CandidateSignUpSection();
}

class _CandidateSignUpSection extends State<CandidateSignUpSection> {
  String Username, Email, Mobile, Password;
  bool passwordVisible;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    passwordVisible = false;
  }

  Widget NameField() {
    return TextFormField(
        maxLength: 10,
        decoration: InputDecoration(labelText: "Username"),
        validator: (String value) {
          if (value.length < 6) {
            return '6 Letters Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          Username = value;
        });
  }

  Widget EmailField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Email"),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return 'Valid And Correct Email is Required';
          }
          return null;
        },
        onSaved: (String value) {
          Email = value;
        });
  }

  Widget PhoneField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Phone"),
        keyboardType: TextInputType.phone,
        validator: (String value) {
          if (!RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(value)) {
            return 'Correct 10 digit Phone Number is Required';
          }
          return null;
        },
        onSaved: (String value) {
          Mobile = value;
        });
  }

  Widget PasswordField() {
    return TextFormField(
        obscureText: passwordVisible, //This will obscure text dynamically
        decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
        ),
        validator: (String value) {
          if (value.length < 8) {
            return '8 Letter Password is Required';
          }
          return null;
        },
        onSaved: (String value) {
          Password = value;
        });
  }

  int _state = 0;

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 0;
      });
    });
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "GET OTP",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candidate SignUp Page'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.cyanAccent,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: globalKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Color(0xffFDCF09),
                            radius: 70.0,
                            backgroundImage:
                                AssetImage('assets/user_login_image.png'),
                          ),
                          NameField(),
                          PhoneField(),
                          EmailField(),
                          PasswordField(),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/CandidateLogin");
                            },
                            child: new Text(
                              "Already Have An Account ?  Login Here",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (globalKey.currentState.validate()) {
                                globalKey.currentState.save();

                                setState(() {
                                  if (_state == 0) {
                                    animateButton();
                                  }
                                });

                                // remaining code here for getting otp and saving it in shared preferences.
                                // make POST request
                                Response response = await post(
                                    "http://freetechtip.in/app/file/candidate_signup.php",
                                    body: {
                                      'username_check': 'username_check',
                                      'username': Username,
                                      'contact_check': 'contact_check',
                                      'contact': Mobile,
                                      'save': 'save',
                                      'password': Password,
                                    });

                                Map<String, dynamic> map =
                                    jsonDecode(response.body);

                                if (map['username'] == 'taken') {
                                  Fluttertoast.showToast(
                                      msg: "Username Already Exists",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (map['contact'] == 'taken') {
                                  Fluttertoast.showToast(
                                      msg: "Contact Already Exists",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if(map['otp'].toString().isNotEmpty){
                                  addIntToSF() async {
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                    prefs.setInt('Otp', map['otp']);
                                    prefs.setInt('Mobile', int.parse(Mobile));
                                    prefs.setString('Username', Username);
                                  }

                                  addIntToSF();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CandidateMobileVerification()));
                                }

                              } else {
                                return;
                              }
                            },
                            highlightColor: Colors.pinkAccent,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40),
                              side: new BorderSide(color: Colors.red),
                            ),
                            child: setUpButtonChild(),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
