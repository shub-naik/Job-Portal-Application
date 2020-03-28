import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'CandidateJobDetail.dart';

class CandidateFilterJobs extends StatefulWidget {
  @override
  _CandidateFilterJobsState createState() => _CandidateFilterJobsState();
}

class _CandidateFilterJobsState extends State<CandidateFilterJobs> {
  bool makableBool = false;
  bool fadchiBool = false;
  bool bothBool = false;
  bool maleBool = false;
  bool femaleBool = false;
  bool tenTotwentyBool = false;
  bool tenTothirtyBool = false;
  bool moreThanthirty = false;
  bool fresherBool = false;

  List<Map<String, dynamic>> suggesterList = [];
  List<Map<String, dynamic>> originalList = [];

  static Future<List<Map<String, dynamic>>> getJobList() async {
    List<Map<String, dynamic>> suggestionList = [];
    var data =
        await post('http://freetechtip.in/app/file/candidate_show_jobs_list.php');

    var jsonData = jsonDecode(data.body);
    jsonData.forEach((element) {
      suggestionList.add(element);
    });
    return suggestionList;
  }

  void filterList() {
    int flag = 0;
    List<String> addedAlready = [];
    List<Map<String, dynamic>> filteredList = [];
    if (makableBool) {
      flag = 1;
      originalList.forEach((element) {
        if (element['Category'] == "MAKABLE" &&
            !addedAlready.contains(element['id'])) {
          filteredList.add(element);
          addedAlready.add(element['id']);
        }
      });
      suggesterList = filteredList;
    }
    if (fadchiBool) {
      flag = 1;
      originalList.forEach((element) {
        if (element['Category'] == "FADCHI" &&
            !addedAlready.contains(element['id'])) {
          filteredList.add(element);
          addedAlready.add(element['id']);
        }
      });
      suggesterList = filteredList;
    }
    if (bothBool) {
      flag = 1;
      originalList.forEach((element) {
        if (element['Category'] == "Makable & Fadchi (Both)" &&
            !addedAlready.contains(element['id'])) {
          filteredList.add(element);
          addedAlready.add(element['id']);
        }
      });
      suggesterList = filteredList;
    }
    if (maleBool) {
      flag = 1;
      originalList.forEach((element) {
        if (element['Gender'] == "Male" &&
            !addedAlready.contains(element['id'])) {
          filteredList.add(element);
        }
      });
      suggesterList = filteredList;
    }
    if (femaleBool) {
      flag = 1;
      originalList.forEach((element) {
        if (element['Gender'] == "Female" &&
            !addedAlready.contains(element['id'])) {
          filteredList.add(element);
        }
      });
      suggesterList = filteredList;
    }

    if (flag == 0) {
      suggesterList = originalList;
    }
  }

  @override
  void initState() {
    super.initState();
    _CandidateFilterJobsState.getJobList().then((value) => {
          setState(() {
            suggesterList = value;
            originalList = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Filter Jobs"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Filter By Category',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // [Monday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Makable"),
                  Checkbox(
                    value: makableBool,
                    onChanged: (bool value) {
                      setState(() {
                        makableBool = value;
                        filterList();
                      });
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Fadchi"),
                  Checkbox(
                    value: fadchiBool,
                    onChanged: (bool value) {
                      setState(() {
                        fadchiBool = value;
                        filterList();
                      });
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Both"),
                  Checkbox(
                    value: bothBool,
                    onChanged: (bool value) {
                      setState(() {
                        bothBool = value;
                        filterList();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Filter By Gender',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // [Monday] checkbox
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Male"),
                  Checkbox(
                    value: maleBool,
                    onChanged: (bool value) {
                      setState(() {
                        maleBool = value;
                        filterList();
                      });
                    },
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Female"),
                  Checkbox(
                    value: femaleBool,
                    onChanged: (bool value) {
                      setState(() {
                        femaleBool = value;
                        filterList();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          suggesterList.length == 0
              ? Center(
                  child: Text(
                  'No Data Found',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))
              : Expanded(
                  child: ListView.builder(
                      itemCount: suggesterList.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => CandidateJobDetail(
                                        JobDetail: suggesterList[index])));
                          },
                          leading:
                              suggesterList[index]['Job-type'] == "Part-Time"
                                  ? CircleAvatar(
                                      backgroundColor: Colors.orangeAccent,
                                      backgroundImage:
                                          AssetImage('assets/part_time.png'))
                                  : CircleAvatar(
                                      backgroundColor: Colors.orangeAccent,
                                      backgroundImage:
                                          AssetImage('assets/full_time.png')),
                          title: Text(
                            suggesterList[index]['job-title']
                                .toString()
                                .toLowerCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            suggesterList[index]['description']
                                .toString()
                                .toLowerCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          ),
                        );
                      }),
                )
        ],
      ),
    );
  }
}
