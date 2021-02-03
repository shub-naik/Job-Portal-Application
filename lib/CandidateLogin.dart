import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Animation/FadeAnimation.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Candidate_Zone.dart';
import 'app_translations.dart';

class CandidateLogin extends StatefulWidget {
  @override
  _CandidateLoginState createState() => _CandidateLoginState();
}

class _CandidateLoginState extends State<CandidateLogin> {
  bool password_validate = false;
  bool phone_validate = false;
  final PhoneController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      PhoneController.dispose();
      PasswordController.dispose();
      super.dispose();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/light-2.png'))),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Candidate Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: PhoneController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone Number",
                                        errorText: phone_validate
                                            ? AppTranslations.of(context).text(
                                                "Phone Number Value Can\\'t Be Empty")
                                            : null,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: PasswordController,
                                    decoration: InputDecoration(
                                        errorText: password_validate
                                            ? AppTranslations.of(context).text(
                                                "Password Value Can\\'t Be Empty")
                                            : null,
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              child: new GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    PasswordController.text.isEmpty
                                        ? password_validate = true
                                        : password_validate = false;
                                    PhoneController.text.isEmpty
                                        ? phone_validate = true
                                        : phone_validate = false;
                                  });

                                  if (!password_validate && !phone_validate) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                        title: Text(
                                            "Validating, Please Wait ....."),
                                        content: SpinKitRotatingCircle(
                                          color: Colors.blue,
                                          size: 50.0,
                                        ),
                                      ),
                                    );
                                    // send post request to the EmployerLogin Page
                                    Response response = await post(
                                        "http://freetechtip.in/app/file/candidate_login.php",
                                        body: {
                                          'Phone': PhoneController.text,
                                          'Password': PasswordController.text
                                        });
                                    Map<String, dynamic> map =
                                        jsonDecode(response.body);
                                    if (map['error'] == 'false') {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "SuccessFully Candidate Login",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      // save the user to the Shared Preferences.
                                      addCandidatePhoneNumberToSF() async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('CandidatePhoneNumber',
                                            PhoneController.text.toString());
                                        prefs.setString('Username',
                                            map['username'].toString());
                                        prefs.setString('UserId',
                                            map['user_id'].toString());
                                        prefs.setString('FirstName',
                                            map['firstname'].toString());
                                        prefs.setString('LastName',
                                            map['lastname'].toString());
                                      }

                                      await addCandidatePhoneNumberToSF();

                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/CandidateZone", (r) => false);
                                      //redirect to the employer dashboard page.
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Candidate_Zone()));
                                    } else {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Invalid Credentials",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: Text(
                                  AppTranslations.of(context).text("Login"),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
