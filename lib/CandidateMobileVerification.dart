import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CandidateSignupPersonalDetails.dart';
import 'EmployerProfileSection.dart';

class CandidateMobileVerification extends StatefulWidget {
  @override
  _CandidateMobileVerificationState createState() =>
      _CandidateMobileVerificationState();
}

class _CandidateMobileVerificationState
    extends State<CandidateMobileVerification> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Timer timer;
  int counter = 60;
  bool isExpired = false;

  @override
  void initState() {
    CallTimer();
  }

  CallTimer() {
    counter = 60;
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      counter--;
      setState(() {});
    });
    Timer(Duration(seconds: 60), () {
      timer.cancel();
      isExpired = true;
      setState(() {});
      Fluttertoast.showToast(
          msg: "OTP Expired",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 60,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Widget resendOTP() {
    return RaisedButton(
      child: Text('Resend OTP'),
      onPressed: () {
        //await CallAgain();
        CallTimer();
        setState(() {});
      },
    );
  }

  CallAgain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int Mobile = prefs.getInt('Mobile');
    Response response =
        await post("http://freetechtip.in/app/file/ResendOtp.php", body: {
      "mobile": Mobile,
    });

    Map<String, dynamic> map = jsonDecode(response.body);
    prefs.setInt('Otp', map['otp']);
    print('C Otp ' + map['otp']);
  }

  @override
  Widget build(BuildContext context) {
    int OTPValueEntered;

    Widget PhoneField() {
      return TextFormField(
          decoration: InputDecoration(labelText: "Enter 5 Digit OTP"),
          keyboardType: TextInputType.phone,
          maxLength: 5,
          validator: (String value) {
            if (!RegExp(r"^(?:[+0]9)?[0-9]{5}$").hasMatch(value)) {
              return 'Correct 5 digit OTP is Required';
            }
            return null;
          },
          onSaved: (String value) {
            OTPValueEntered = int.parse(value);
          });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Candidate Mobile Verification")),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(key: globalKey, child: PhoneField()),
              RaisedButton(
                  onPressed: () {
                    if (globalKey.currentState.validate()) {
                      globalKey.currentState.save();
                      // code here for otp verification.
                      getIntValuesSF() async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        int PreferenceOtpValue = prefs.getInt('Otp');

                        if (PreferenceOtpValue == OTPValueEntered) {
                          Fluttertoast.showToast(
                              msg: "Mobile Number Verified Successfully",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 10,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          timer.cancel();
                          String username = prefs.getString("Username");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CandidateSignupPersonalDetails(
                                          username: username,
                                          mobile: prefs
                                              .getInt("Mobile")
                                              .toString())));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Incorrect OTP Entered ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 10,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }

                      getIntValuesSF();
                    } else {
                      return;
                    }
                  },
                  child: Text("Verify Mobile Number")),
              Text("OTP will expire in " + counter.toString() + " seconds"),
              isExpired ? resendOTP() : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
