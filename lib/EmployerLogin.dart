import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'EmployerZone.dart';
import 'Animation/FadeAnimation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmployerLogin extends StatefulWidget {
  @override
  _EmployerLoginState createState() => _EmployerLoginState();
}

class _EmployerLoginState extends State<EmployerLogin> {
  GoogleSignInObject() {
    return GoogleSignIn(
      scopes: [
        'email',
      ],
    );
  }

  GoogleSignIn googleSignIn = null;

  _login() async {
    try {
      googleSignIn = GoogleSignInObject();
      await googleSignIn.signIn();
      setState(() {});
    } catch (error) {}
  }

  bool password_validate = false;
  bool email_validate = false;
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      EmailController.dispose();
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
                            )),
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
                                  "Employer Login",
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
                                    controller: EmailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        errorText: email_validate
                                            ? 'Email Value Can\'t Be Empty'
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
                                            ? 'Password Value Can\'t Be Empty'
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
                                    EmailController.text.isEmpty
                                        ? email_validate = true
                                        : email_validate = false;
                                  });

                                  if (!password_validate && !email_validate) {
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
                                        "http://freetechtip.in/app/file/employer_login.php",
                                        body: {
                                          'Email': EmailController.text,
                                          'Password': PasswordController.text
                                        });
                                    Map<String, dynamic> map =
                                        jsonDecode(response.body);
                                    print('-----------------------------------------');
                                    print(map);
                                    print('-----------------------------------------');
                                    if (map['success'] == 'true') {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "SuccessFully Login",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      // save the user to the Shared Preferences.
                                      addEmployerEmailToSF() async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString('EmployerEmail',
                                            EmailController.text.toString());
                                        prefs.setString('emp_id',
                                            map['emp_id'].toString());
                                        prefs.setString('emp_name',
                                            map['emp_name'].toString());
                                      }

                                      await addEmployerEmailToSF();

                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/EmployerZone", (r) => false);
                                      //redirect to the employer dashboard page.
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Employer_Zone()));
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
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              )),
                        ),
                        Text("OR",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 20)),
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              )),
                        ),
                      ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SignInButton(
                            Buttons.Google,
                            text: "Login with Google",
                            onPressed: () async {
                              await _login();
                              Response response = await post(
                                  "http://freetechtip.in/app/file/employer_login.php",
                                  body: {
                                    'Email': googleSignIn.currentUser.email,
                                    'email_login':'email_login'
                                  });

                              Map<String, dynamic> map =
                                  jsonDecode(response.body);
                              print('-----------------------------------------');
                              print(map);
                              print('-----------------------------------------');
                              if (map['error'] == "true") {
                                Fluttertoast.showToast(
                                    msg: googleSignIn.currentUser.email +
                                        " is not linked with any of the Accounts",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                googleSignIn.signOut();
                              } else {
                                Fluttertoast.showToast(
                                    msg: googleSignIn.currentUser.email + " Logged In Successfully",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                SharedPreferences prefs =
                                await SharedPreferences
                                    .getInstance();
                                prefs.setString('EmployerEmail',
                                    EmailController.text.toString());
                                prefs.setString('emp_id',
                                    map['emp_id'].toString());
                                prefs.setString('emp_name',
                                    map['emp_name'].toString());
                                Navigator.pushNamedAndRemoveUntil(context,
                                    "/EmployerZone", (r) => false);
                                //redirect to the employer dashboard page.
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Employer_Zone()));
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
