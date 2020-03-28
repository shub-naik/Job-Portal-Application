import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CandidateJobsAppliedTab extends StatefulWidget {
  const CandidateJobsAppliedTab({Key key}) : super(key: key);

  @override
  _CandidateJobsAppliedTabState createState() =>
      _CandidateJobsAppliedTabState();
}

class _CandidateJobsAppliedTabState extends State<CandidateJobsAppliedTab> {
  Future<List<Map<String, dynamic>>> getAppliedJobsList() async {
    final prefrences = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> returnAppliedJobList = [];
    var data = await post(
        'http://freetechtip.in/app/file/candidate_applied_jobs.php',
        body: {'userid': prefrences.getString('UserId')});

    var jsonData = jsonDecode(data.body);
    jsonData.forEach((element) {
      returnAppliedJobList.add(element);
    });

    return returnAppliedJobList;
  }

  Future<List<Map<String, dynamic>>> allAppliedJobsList;

  @override
  void initState() {
    allAppliedJobsList = getAppliedJobsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAppliedJobsList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return Dismissible(
                      key: PageStorageKey(snapshot.data[index]['apply_id']),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10),
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) async {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(snapshot.data[index]['jobTitle'] +
                                  " dismissed")));

                          await post(
                              "http://freetechtip.in/app/file/applied_jobs_delete.php",
                              body: {
                                'apply_id': snapshot.data[index]['apply_id'],
                              });
                          setState(() {
//                            allAppliedJobsList.then((value) => () {
//                                  value.removeWhere((element) =>
//                                      element['apply_id'] ==
//                                      snapshot.data[index]['apply_id']);
//                                  allAppliedJobsList
//                                      .then((value) => print(value));
//                                });
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: Colors.grey[300],
                            child: ListTile(
                              title: Text(snapshot.data[index]['jobTitle'] +
                                  " - " +
                                  snapshot.data[index]['companyName']),
                              subtitle: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 1,
                                              child: Icon(Icons.location_on)),
                                          Expanded(
                                              flex: 9,
                                              child: Text(snapshot.data[index]
                                                      ['Country'] +
                                                  " , " +
                                                  snapshot.data[index]
                                                      ['State'] +
                                                  " , " +
                                                  snapshot.data[index]
                                                      ['City'])),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 1,
                                              child: Icon(Icons.alarm)),
                                          Expanded(
                                              flex: 9,
                                              child: Text('Applied at - ' +
                                                  snapshot.data[index]
                                                      ['applyDate'])),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  });
          }
        });
  }
}
