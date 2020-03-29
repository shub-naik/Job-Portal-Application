import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool passwordVisible1, passwordVisible2, passwordVisible3;
  String Password;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final NewPasswordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  void initState() {
    passwordVisible1 = false;
    passwordVisible2 = false;
    passwordVisible3 = false;
  }

  Widget OldPasswordField() {
    return TextFormField(
        controller: PasswordController,
        obscureText: passwordVisible1,
        //This will obscure text dynamically
        decoration: InputDecoration(
          labelText: "Old Password",
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible3 state choose the icon
              passwordVisible1 ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible3 variable
              setState(() {
                passwordVisible1 = !passwordVisible1;
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

  Widget NewPasswordField() {
    return TextFormField(
      controller: NewPasswordController,
      obscureText: passwordVisible2, //This will obscure text dynamically
      decoration: InputDecoration(
        labelText: "New Password",
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible3 state choose the icon
            passwordVisible2 ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible3 variable
            setState(() {
              passwordVisible2 = !passwordVisible2;
            });
          },
        ),
      ),
      validator: (String value) {
        if (value.length < 8) {
          return '8 Letter New Password is Required';
        } else {
          return null;
        }
      },
    );
  }

  Widget ConfirmPasswordField() {
    return TextFormField(
        controller: ConfirmPasswordController,
        obscureText: passwordVisible3, //This will obscure text dynamically
        decoration: InputDecoration(
          labelText: "Confirm Password",
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible3 state choose the icon
              passwordVisible3 ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible3 variable
              setState(() {
                passwordVisible3 = !passwordVisible3;
              });
            },
          ),
        ),
        validator: (String value) {
          if (value.length < 8) {
            return '8 Letter Confirm Password is Required';
          } else if (value != NewPasswordController.text) {
            return 'Password Mismatch';
          } else {
            return null;
          }
        });
  }

  void ChangePassword() async {
    if (globalKey.currentState.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Validating Password, Please Wait ....."),
          content: SpinKitRotatingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response response =
          await post("http://freetechtip.in/app/file/change_pass.php", body: {
        'old': PasswordController.text,
        'pass': NewPasswordController.text,
        'mobile': prefs.getString('CandidatePhoneNumber'),
      });

      if (response != null) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['error'] == "old_pass_error") {
          Fluttertoast.showToast(
              msg: "Invalid Old Password",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
              msg: "Password Updated Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, "/CandidateZone", (r) => false);
        }
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Database Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
                key: globalKey,
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      'Change Password',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                    OldPasswordField(),
                    NewPasswordField(),
                    ConfirmPasswordField(),
                    RaisedButton(
                      onPressed: () {
                        ChangePassword();
                      },
                      child: Text('Change Password'),
                    )
                  ],
                )),
          ),
        ));
  }
}
