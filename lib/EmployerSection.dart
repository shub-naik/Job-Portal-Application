import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heera_polish/EmployerMobileVerification.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployerSection extends StatefulWidget {
  @override
  _EmployerSectionState createState() => _EmployerSectionState();
}

class _EmployerSectionState extends State<EmployerSection> {
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
          color: Colors.pinkAccent,
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
        title: Text('SignUp Page'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.2,
                    color: Colors.black,
                  ),
                ),
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
                            backgroundImage: AssetImage('assets/prof.jpeg'),
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
                              Navigator.pushNamed(context, "/EmployerLogin");
                            },
                            child: new Text(
                              "Already Have An Account ?  Login Here",
                              style: TextStyle(
                                  color: Colors.blueAccent,
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

                                Response response = await post(
                                    "http://freetechtip.in/app/file/employer_signup.php",
                                    body: {
                                      'username': Username,
                                      'email': Email,
                                      'password': Password,
                                      "sendopt": "sendopt",
                                      "contact": Mobile
                                    });

                                Map<String, dynamic> map =
                                    jsonDecode(response.body);

                                print(map);

                                if (map['otp'].toString().isNotEmpty) {
                                  addIntToSF() async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setInt('Otp', map['otp']);
                                    prefs.setInt('Mobile', int.parse(Mobile));
                                    prefs.setString('Username', Username);
                                    prefs.setString('Email', Email);
                                  }

                                  addIntToSF();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EmployerMobileVerification()));
                                }

                                if (map['taken'].toString().isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Username or Contact or Email already exists. So, Please Login and enter your Profile Details.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 60,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              }
                            },
                            highlightColor: Colors.blue[900],
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(23),
                                side: BorderSide(
                                    color: Colors.pinkAccent, width: 3)),
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
