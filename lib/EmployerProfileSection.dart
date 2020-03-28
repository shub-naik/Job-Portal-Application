import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heera_polish/EmployerLogin.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';

import 'EmployerZone.dart';

class EmployerProfileSection extends StatefulWidget {
  String username, Email;
  int Mobile;

  EmployerProfileSection({this.username, this.Mobile, this.Email});

  @override
  _EmployerProfileSectionState createState() =>
      _EmployerProfileSectionState(username, Mobile, Email);
}

class _EmployerProfileSectionState extends State<EmployerProfileSection> {
  int Mobile;
  String username,
      Email,
      fullname,
      organizationName,
      designation,
      facebook,
      linkedin,
      twitter,
      google;
  int teamSize = 0;
  bool _validate = false;
  final _text = TextEditingController();
  String currentAccountSelected = 'Employer';
  String currentServicesSelected = 'Makable';
  var account = ['Employer', 'Individual', 'Consultant'];
  var services = ['Makable', 'Fadchi', 'Makable and Fadchi (Both)'];
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  _EmployerProfileSectionState(this.username, this.Mobile, this.Email);

  Widget FullNameField() {
    return TextFormField(
        maxLength: 50,
        decoration: InputDecoration(labelText: "Full Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Full Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          fullname = value;
        });
  }

  Widget OrganizationNameField() {
    return TextFormField(
        maxLength: 60,
        decoration: InputDecoration(labelText: "Organization Name"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Organization Name is Required';
          }
          return null;
        },
        onSaved: (String value) {
          organizationName = value;
        });
  }

  Widget DesignationField() {
    return TextFormField(
        maxLength: 60,
        decoration: InputDecoration(labelText: "Designation Field"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Designation is Required';
          }
          return null;
        },
        onSaved: (String value) {
          designation = value;
        });
  }

  Widget FacebookField() {
    return TextFormField(
        maxLength: 100,
        decoration: InputDecoration(labelText: "Facebook Link"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Facebook Link is Required';
          }
          return null;
        },
        onSaved: (String value) {
          facebook = value;
        });
  }

  Widget TwitterField() {
    return TextFormField(
        maxLength: 100,
        decoration: InputDecoration(labelText: "Twitter Link"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Twitter Link is Required';
          }
          return null;
        },
        onSaved: (String value) {
          twitter = value;
        });
  }

  Widget GoogleField() {
    return TextFormField(
        maxLength: 100,
        decoration: InputDecoration(labelText: "Google Link"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Google Link is Required';
          }
          return null;
        },
        onSaved: (String value) {
          google = value;
        });
  }

  Widget LinkedInField() {
    return TextFormField(
        maxLength: 100,
        decoration: InputDecoration(labelText: "LinkedIn Link"),
        validator: (String value) {
          if (value.isEmpty) {
            return 'LinkedIn Link is Required';
          }
          return null;
        },
        onSaved: (String value) {
          linkedin = value;
        });
  }

  Widget TeamSizeField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Team Size"),
        keyboardType: TextInputType.number,
        maxLength: 3,
        validator: (String value) {
          if (!RegExp(r"^(?:[+0]9)?[0-9]{2,3}$").hasMatch(value)) {
            return 'Team Size is Required';
          }
          return null;
        },
        onSaved: (String value) {
          teamSize = int.parse(value);
        });
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile for $username'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.cyanAccent,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                        key: globalKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              "Username : " + username,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButton<String>(
                              items: account.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem));
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this.currentAccountSelected =
                                      newValueSelected;
                                });
                              },
                              value: currentAccountSelected,
                            ),
                            OrganizationNameField(),
                            FullNameField(),
                            TeamSizeField(),
                            DesignationField(),
                            DropdownButton<String>(
                              items: services.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem));
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this.currentServicesSelected =
                                      newValueSelected;
                                });
                              },
                              value: currentServicesSelected,
                            ),
                            TextField(
                              controller: _text,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Description',
                                errorText:
                                    _validate ? 'Value Can\'t Be Empty' : null,
                              ),
                              maxLines: null,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              'Social Accounts',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            FacebookField(),
                            TwitterField(),
                            GoogleField(),
                            LinkedInField(),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              'Contact Accounts',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Mobile : " + Mobile.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Email : " + Email.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: RaisedButton(
                                splashColor: Colors.blue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40),
                                  side: new BorderSide(color: Colors.red),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _text.text.isEmpty
                                        ? _validate = true
                                        : _validate = false;
                                  });
                                  if (globalKey.currentState.validate() &&
                                      !_validate) {
                                    globalKey.currentState.save();
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

                                    // Code Here for sending the post request to the server for saving the profile information and redirect the user to login screen
                                    Response response = await post(
                                        "http://freetechtip.in/app/file/employer_profile.php",
                                        body: {
                                          "Username": username,
                                          "Fullname": fullname,
                                          "OrganizationName": organizationName,
                                          "Designation": designation,
                                          "TeamSize": teamSize.toString(),
                                          "Description": _text.text.toString(),
                                          "Service": currentServicesSelected,
                                          "Account": currentAccountSelected,
                                          'Facebook':facebook,
                                          'Google':google,
                                          'Twitter':twitter,
                                          'LinkedIn':linkedin,
                                          'Mobile':Mobile.toString(),
                                          'Email':Email.toString(),
                                          'get_employer_profile':'get_employer_profile'
                                        });


                                    Map<String, dynamic> map = jsonDecode(response.body);
                                    print(map);

                                    if(map['profile'].toString().isNotEmpty){
                                      Navigator.pop(context);
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          "/employer_profile_section", (r) => false);
                                      //redirect to the employer dashboard page.
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployerLogin()));
                                    }
                                  }
                                },
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Send Profile Data',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
