import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CandidateProfileTab extends StatefulWidget {
  @override
  _CandidateProfileTabState createState() => _CandidateProfileTabState();
}

class _CandidateProfileTabState extends State<CandidateProfileTab> {
  List<Map<String, dynamic>> suggesterList = [];
  List<Map<String, dynamic>> originalList = [];

  static Future<List<Map<String, dynamic>>> getJobAlertList() async {
    List<Map<String, dynamic>> suggestionList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await post(
        'http://freetechtip.in/app/file/candidate_profile.php',
        body: {'username': prefs.getString('Username')});

    List<dynamic> tempList = jsonDecode(response.body);
    tempList.forEach((element) {
      suggestionList.add(element);
    });
    return suggestionList;
  }

  @override
  void initState() {
    _CandidateProfileTabState.getJobAlertList().then((value) => {
          setState(() {
            suggesterList = value;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
            itemCount: suggesterList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Card(
                  child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color(0xffFDCF09),
                    radius: 70.0,
                    backgroundImage: NetworkImage(
                        suggesterList[index]['user_profile_image'].toString()
                        ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Username : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['username'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'First Name : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['firstName'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Father Name : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['fatherName'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Mobile Number : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['mobile'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Category : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['categories'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'SubCategory : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['subcategory'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'DOB  : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['dob'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            'Experience : ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            suggesterList[index]['experiance'] + "years",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
            }));
  }
}
