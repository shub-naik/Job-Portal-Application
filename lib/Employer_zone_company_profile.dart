import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Employer_zone_company_profile extends StatefulWidget {
  @override
  _Employer_zone_company_profileState createState() =>
      _Employer_zone_company_profileState();
}

class _Employer_zone_company_profileState
    extends State<Employer_zone_company_profile> {
  bool isEditable = false;

  String username, fullname, organizationName, designation;
  int teamSize = 0;
  bool _validate = false;
  final _text = TextEditingController();
  String currentAccountSelected = 'Employer';
  String currentServicesSelected = 'Makable';
  var account = ['Employer', 'Individual', 'Consultant'];
  var services = ['Makable', 'Fadchi', 'Makable and Fadchi (Both)'];
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  Future<List<Map<String, dynamic>>> getCompanyProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('..................');
    print(prefs.getString('emp_name'));
    print('..................');
    var data = await post(
        'http://freetechtip.in/app/file/get_employer_profile.php',
        body: {
          'get_employer_profile': 'get_employer_profile',
          'username': prefs.getString('emp_name')
        });

    List<Map<String, dynamic>> returnJobList = [];

    var jsonData = jsonDecode(data.body);
    print('-----------------');
    print(jsonData);
    print('-----------------');

    returnJobList.add(jsonData);
    return returnJobList;
  }

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
    double screenWidth, screenHeight;

    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Scaffold(
        body: FutureBuilder(
            future: getCompanyProfile(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            color: Colors.lightBlueAccent,
                            child: new Container(
                              padding: EdgeInsets.only(
                                  left: 30, right: 50, top: 30, bottom: 30),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    snapshot.data[index]['username'],
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  new Text(
                                    snapshot.data[index]['company_name'],
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  new Text(
                                    snapshot.data[index]['email'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              color: Colors.white,
                              child: new Container(
                                padding: EdgeInsets.all(12),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Company Details",
                                            style: TextStyle(fontSize: 20))),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Account-Type",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]
                                                ['account_type'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Designation",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['designation'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Requirement Services",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['services'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Team Size",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['Team-Size'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Contact No",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['contact'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Facebook",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['fb'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("Twitter",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['twitter'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2.3,
                                            color: Colors.pinkAccent),
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.check_circle),
                                        dense: true,
                                        title: Text("linkedin",
                                            style: TextStyle(fontSize: 18)),
                                        trailing: Text(
                                            snapshot.data[index]['Linkedin'],
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: new Container(
                              padding: EdgeInsets.all(10),
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Company Description",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.all(23),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              width: 2.8,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          child: Text(
                                            snapshot.data[index]['description'],
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
              }
            }));
  }
}
