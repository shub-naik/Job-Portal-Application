import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ShowCandidateDetails.dart';
import 'ShowJobDetails.dart';

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({Key key, this.title, this.subtitle, this.publishDate})
      : super(key: key);

  final String title;
  final String subtitle;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$publishDate',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo(
      {Key key,
      this.title, // Here the Job Title appears
      this.subtitle, // Here the Candidate Name, Surname appears
      this.publishDate, // Here the candidate applydate for the job appears
      this.snapshot,
      this.index})
      : super(key: key);

  final String title;
  final String subtitle;
  final String publishDate;
  final AsyncSnapshot snapshot;
  final int index;

  void openModalSheet(BuildContext context, int index) {
    final flatButtonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 160.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Select an Action',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Show Candidate Details'),
                  onPressed: () async {
                    Response response = await post(
                        "http://freetechtip.in/app/file/overall_candidates_applied_for_jobs.php",
                        body: {
                          'candidate_info': 'candidate_info',
                          'user_id': this.snapshot.data[index]['userid']
                        });
                    if (response.body == "null") {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "User Profile Doesn't Exists For This User",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Navigator.pop(context);
                      print(jsonDecode(response.body));
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => ShowCandidateDetails(
                              CandidateDetail: jsonDecode(response.body)),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Show Job Details'),
                  onPressed: () async {
                    Response response = await post(
                        "http://freetechtip.in/app/file/overall_candidates_applied_for_jobs.php",
                        body: {
                          'job_details': 'job_details',
                          'job_id': this.snapshot.data[index]['jobid']
                        });
                    print(response.body);
                    if (response.body == "null") {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "User Profile Doesn't Exists For This User",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Navigator.pop(context);
                      print(jsonDecode(response.body));
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => ShowJobDetails(
                              JobDetail: jsonDecode(response.body)),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 120,
        child: Card(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: _ArticleDescription(
                      title: title,
                      subtitle: subtitle,
                      publishDate: publishDate,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      openModalSheet(context, index);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Employer_zone_home extends StatefulWidget {
  @override
  _Employer_zone_homeState createState() => _Employer_zone_homeState();
}

class _Employer_zone_homeState extends State<Employer_zone_home> {
  // For Listing all the jobs on the home page
  static Future<List<Map<String, dynamic>>> getAppliedCandidatesForJob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await post(
        'http://freetechtip.in/app/file/overall_candidates_applied_for_jobs.php',
        body: {
          'view_all_candidates': 'view_all_candidates',
          'emp_id': prefs.getString('emp_id'),
        });

    List<Map<String, dynamic>> returnJobList = [];

    var jsonData = jsonDecode(response.body);
    print(jsonData);

    jsonData.forEach((element) {
      returnJobList.add(element);
    });
    return returnJobList;
  }

  Future<List<Map<String, dynamic>>> allJobsList;

  @override
  void initState() {
    allJobsList = getAppliedCandidatesForJob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.all(19),
            child: FutureBuilder(
                future: allJobsList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return CustomListItemTwo(
                                key: PageStorageKey(
                                    snapshot.data[index]['apply_id']),
                                title: snapshot.data[index]['jobTitle'],
                                subtitle: "Applied By " +
                                    snapshot.data[index]['first_name'] +
                                    " " +
                                    snapshot.data[index]['last_name'],
                                publishDate: snapshot.data[index]['applyDate'],
                                snapshot: snapshot,
                                index: index);
                          });
                  }
                })));
  }
}
